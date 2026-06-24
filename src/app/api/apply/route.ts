import { NextRequest, NextResponse } from 'next/server'
import Anthropic from '@anthropic-ai/sdk'
import { Resend } from 'resend'
import { createClient } from '@supabase/supabase-js'

const anthropic = new Anthropic({ apiKey: process.env.ANTHROPIC_API_KEY! })
const resend = new Resend(process.env.RESEND_API_KEY!)

// Supabase admin client (service role — bypasses RLS for user creation)
const supabaseAdmin = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL!,
  process.env.SUPABASE_SERVICE_ROLE_KEY!,
  { auth: { autoRefreshToken: false, persistSession: false } }
)

const ELIGIBILITY_RUBRIC = `
You are an admissions evaluator for IBEQA (International Board for Education Quality Assurance).
Evaluate the institution's eligibility based on these 6 minimum requirements:

1. TYPE: Must be a university or higher education institution (not a school, training center, or non-degree-granting body).
2. SENIORITY: Must have been operating for at least 3 years (founded in 2022 or earlier).
3. STUDENTS: Must have at least 500 active enrolled students.
4. PROGRAMS: Must offer at least 2 degree programs (bachelor's or postgraduate).
5. RECOGNITION: Must have official recognition or authorization from the country's government education authority. "Pending" is borderline — flag it but do not automatically reject.
6. CONTACT: Must provide a valid institutional email (not a personal Gmail/Yahoo/Hotmail) and the contact must be an institutional representative.

Respond ONLY with a valid JSON object (no markdown, no explanation, no extra text) in this exact format:
{
  "approved": true | false,
  "reasons": ["reason 1", "reason 2", ...],
  "message": "One warm, professional sentence summarizing the decision."
}

If approved, "reasons" should list 1-3 strengths. If rejected, list each failed criterion as a specific, constructive reason.
`

export async function POST(request: NextRequest) {
  try {
    const body = await request.json()
    const {
      institution_name,
      country,
      founded_year,
      student_count,
      program_count,
      has_official_recognition,
      website,
      contact_name,
      contact_email,
      description,
    } = body

    // Build the application summary for Claude
    const applicationText = `
Institution Name: ${institution_name}
Country: ${country}
Year Founded: ${founded_year}
Active Students: ${student_count}
Degree Programs Offered: ${program_count}
Official Government Recognition: ${has_official_recognition}
Website: ${website || 'Not provided'}
Primary Contact: ${contact_name} (${contact_email})
Description: ${description}
    `.trim()

    // Call Claude to evaluate eligibility
    const response = await anthropic.messages.create({
      model: 'claude-opus-4-8',
      max_tokens: 1024,
      messages: [
        {
          role: 'user',
          content: `${ELIGIBILITY_RUBRIC}\n\nApplication to evaluate:\n\n${applicationText}`,
        },
      ],
    })

    const rawText = response.content[0].type === 'text' ? response.content[0].text : ''

    let evaluation: { approved: boolean; reasons: string[]; message: string }
    try {
      // Extract JSON even if Claude adds any extra text
      const jsonMatch = rawText.match(/\{[\s\S]*\}/)
      evaluation = JSON.parse(jsonMatch ? jsonMatch[0] : rawText)
    } catch {
      return NextResponse.json(
        { approved: false, reasons: ['Evaluation system error. Please try again.'], message: '' },
        { status: 500 }
      )
    }

    if (evaluation.approved) {
      // Create user in Supabase with institution_admin role
      const { data: userData, error: userError } = await supabaseAdmin.auth.admin.createUser({
        email: contact_email,
        email_confirm: true,
        user_metadata: {
          full_name: contact_name,
          role: 'institution_admin',
          institution_name,
          country,
        },
      })

      if (userError && !userError.message.includes('already registered')) {
        console.error('Error creating user:', userError)
      }

      // Send magic link (OTP) via Supabase so the user gets a login link
      const { error: otpError } = await supabaseAdmin.auth.admin.generateLink({
        type: 'magiclink',
        email: contact_email,
        options: {
          redirectTo: `${process.env.NEXT_PUBLIC_SITE_URL}/dashboard`,
        },
      })

      // Fallback: send approval email via Resend with login instructions
      await resend.emails.send({
        from: 'IBEQA Admissions <no-reply@ajucon.org.pe>',
        to: contact_email,
        subject: `Your institution meets IBEQA eligibility requirements — ${institution_name}`,
        html: `
          <div style="font-family: sans-serif; max-width: 600px; margin: 0 auto; padding: 32px; color: #1a1a1a;">
            <div style="background: #1B2B5E; padding: 20px 24px; border-radius: 12px 12px 0 0;">
              <h1 style="color: white; margin: 0; font-size: 20px; font-weight: 700;">IBEQA</h1>
              <p style="color: #93c5fd; margin: 4px 0 0; font-size: 12px;">International Board for Education Quality Assurance</p>
            </div>
            <div style="background: white; border: 1px solid #e5e7eb; border-top: none; border-radius: 0 0 12px 12px; padding: 32px;">
              <p style="font-size: 15px; line-height: 1.6;">Dear <strong>${contact_name}</strong>,</p>
              <p style="font-size: 15px; line-height: 1.6;">
                We are pleased to inform you that <strong>${institution_name}</strong> <span style="color: #16a34a; font-weight: 600;">meets the minimum eligibility requirements</span> to begin the IBEQA accreditation process.
              </p>
              <p style="font-size: 14px; color: #4b5563; line-height: 1.6;">${evaluation.message}</p>

              <div style="background: #f0fdf4; border: 1px solid #bbf7d0; border-radius: 8px; padding: 16px; margin: 24px 0;">
                <p style="margin: 0; font-size: 14px; color: #166534; font-weight: 500;">Next Step: Access Your Dashboard</p>
                <p style="margin: 8px 0 0; font-size: 13px; color: #15803d;">
                  An access link has been sent to this email address. Check your inbox for a separate message from IBEQA with your login link. If you don't see it, check your spam folder.
                </p>
              </div>

              <p style="font-size: 14px; color: #4b5563; line-height: 1.6;">
                Once inside your dashboard, you will be able to:
              </p>
              <ul style="font-size: 14px; color: #4b5563; line-height: 1.8; padding-left: 20px;">
                <li>Invite team members from your institution</li>
                <li>Begin completing your accreditation application forms</li>
                <li>Track your progress across all evaluation components</li>
              </ul>

              <p style="font-size: 13px; color: #9ca3af; margin-top: 32px; border-top: 1px solid #f3f4f6; padding-top: 16px;">
                IBEQA · International Board for Education Quality Assurance<br/>
                This is an automated message. For questions, reply to this email.
              </p>
            </div>
          </div>
        `,
      })
    } else {
      // Send rejection email
      await resend.emails.send({
        from: 'IBEQA Admissions <no-reply@ajucon.org.pe>',
        to: contact_email,
        subject: `Your IBEQA accreditation application — ${institution_name}`,
        html: `
          <div style="font-family: sans-serif; max-width: 600px; margin: 0 auto; padding: 32px; color: #1a1a1a;">
            <div style="background: #1B2B5E; padding: 20px 24px; border-radius: 12px 12px 0 0;">
              <h1 style="color: white; margin: 0; font-size: 20px; font-weight: 700;">IBEQA</h1>
              <p style="color: #93c5fd; margin: 4px 0 0; font-size: 12px;">International Board for Education Quality Assurance</p>
            </div>
            <div style="background: white; border: 1px solid #e5e7eb; border-top: none; border-radius: 0 0 12px 12px; padding: 32px;">
              <p style="font-size: 15px; line-height: 1.6;">Dear <strong>${contact_name}</strong>,</p>
              <p style="font-size: 15px; line-height: 1.6;">
                Thank you for your interest in IBEQA accreditation for <strong>${institution_name}</strong>.
              </p>
              <p style="font-size: 14px; color: #4b5563; line-height: 1.6;">${evaluation.message}</p>

              <div style="background: #fef2f2; border: 1px solid #fecaca; border-radius: 8px; padding: 16px; margin: 24px 0;">
                <p style="margin: 0 0 8px; font-size: 14px; color: #991b1b; font-weight: 500;">Eligibility requirements not met:</p>
                <ul style="margin: 0; padding-left: 20px; font-size: 13px; color: #b91c1c; line-height: 1.8;">
                  ${evaluation.reasons.map(r => `<li>${r}</li>`).join('')}
                </ul>
              </div>

              <p style="font-size: 14px; color: #4b5563; line-height: 1.6;">
                We encourage you to address these points and reapply when your institution meets the minimum eligibility criteria. Our team is happy to answer questions about the accreditation process.
              </p>

              <p style="font-size: 13px; color: #9ca3af; margin-top: 32px; border-top: 1px solid #f3f4f6; padding-top: 16px;">
                IBEQA · International Board for Education Quality Assurance<br/>
                This is an automated message. For questions, reply to this email.
              </p>
            </div>
          </div>
        `,
      })
    }

    return NextResponse.json(evaluation)
  } catch (error) {
    console.error('Apply API error:', error)
    return NextResponse.json(
      { approved: false, reasons: ['A server error occurred. Please try again later.'], message: '' },
      { status: 500 }
    )
  }
}
