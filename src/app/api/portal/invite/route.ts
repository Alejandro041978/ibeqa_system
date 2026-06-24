import { NextRequest, NextResponse } from 'next/server'
import { createClient as createAdminClient } from '@supabase/supabase-js'
import { createClient as createServerClient } from '@/lib/supabase/server'
import { Resend } from 'resend'

const supabaseAdmin = createAdminClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL!,
  process.env.SUPABASE_SERVICE_ROLE_KEY!,
  { auth: { autoRefreshToken: false, persistSession: false } }
)

const resend = new Resend(process.env.RESEND_API_KEY!)

export async function POST(request: NextRequest) {
  // Verify caller is an institution_admin
  const supabase = await createServerClient()
  const { data: { user } } = await supabase.auth.getUser()
  if (!user) return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })

  const callerRole = user.user_metadata?.role
  if (callerRole !== 'institution_admin') {
    return NextResponse.json({ error: 'Only institution admins can invite members.' }, { status: 403 })
  }

  const { full_name, email, institution_id } = await request.json()

  if (!full_name || !email || !institution_id) {
    return NextResponse.json({ error: 'Missing required fields.' }, { status: 400 })
  }

  // Verify institution_id matches caller's institution
  if (user.user_metadata?.institution_id !== institution_id) {
    return NextResponse.json({ error: 'Forbidden.' }, { status: 403 })
  }

  const institutionName = user.user_metadata?.institution_name ?? 'your institution'
  const inviterName = user.user_metadata?.full_name ?? 'Your administrator'

  // Create user or get existing one
  const { data: userData, error: userError } = await supabaseAdmin.auth.admin.createUser({
    email,
    email_confirm: true,
    user_metadata: {
      full_name,
      role: 'institution_user',
      institution_id,
      institution_name: institutionName,
    },
  })

  if (userError && !userError.message.includes('already been registered')) {
    return NextResponse.json({ error: userError.message }, { status: 500 })
  }

  // If user already exists, check they belong to this institution
  if (userError?.message.includes('already been registered')) {
    const { data: { users } } = await supabaseAdmin.auth.admin.listUsers()
    const existing = users.find(u => u.email === email)
    if (existing && existing.user_metadata?.institution_id !== institution_id) {
      return NextResponse.json({ error: 'This email is already registered with a different institution.' }, { status: 409 })
    }
    if (existing && existing.user_metadata?.institution_id === institution_id) {
      return NextResponse.json({ error: 'This person is already a member of your team.' }, { status: 409 })
    }
  }

  // Generate magic link for the new member
  const { data: linkData } = await supabaseAdmin.auth.admin.generateLink({
    type: 'magiclink',
    email,
    options: {
      redirectTo: `${process.env.NEXT_PUBLIC_SITE_URL}/auth/confirm?next=/portal`,
    },
  })

  const magicLink = linkData?.properties?.action_link ?? `${process.env.NEXT_PUBLIC_SITE_URL}/login`

  // Send invitation email
  const { error: emailError } = await resend.emails.send({
    from: 'IBEQA <no-reply@ibeqa.org>',
    to: email,
    subject: `You've been invited to join ${institutionName} on IBEQA`,
    html: `
      <div style="font-family: sans-serif; max-width: 600px; margin: 0 auto; padding: 32px; color: #1a1a1a;">
        <div style="background: #1B2B5E; padding: 20px 24px; border-radius: 12px 12px 0 0;">
          <h1 style="color: white; margin: 0; font-size: 20px; font-weight: 700;">IBEQA</h1>
          <p style="color: #93c5fd; margin: 4px 0 0; font-size: 12px;">International Board for Education Quality Assurance</p>
        </div>
        <div style="background: white; border: 1px solid #e5e7eb; border-top: none; border-radius: 0 0 12px 12px; padding: 32px;">
          <p style="font-size: 15px; line-height: 1.6;">Dear <strong>${full_name}</strong>,</p>
          <p style="font-size: 15px; line-height: 1.6;">
            <strong>${inviterName}</strong> has invited you to collaborate on the IBEQA accreditation application for <strong>${institutionName}</strong>.
          </p>
          <p style="font-size: 14px; color: #4b5563; line-height: 1.6;">
            As a team member, you will be able to contribute to the accreditation application forms and help your institution meet the IBEQA quality standards.
          </p>

          <div style="background: #f0f4ff; border: 1px solid #c7d2fe; border-radius: 8px; padding: 24px; margin: 24px 0; text-align: center;">
            <p style="margin: 0 0 16px; font-size: 14px; color: #3730a3; font-weight: 500;">Access Your Portal</p>
            <a href="${magicLink}" style="display: inline-block; background: #1B2B5E; color: white; text-decoration: none; padding: 12px 28px; border-radius: 8px; font-size: 14px; font-weight: 600;">
              Accept Invitation →
            </a>
            <p style="margin: 16px 0 0; font-size: 11px; color: #6b7280;">This link expires in 24 hours and can only be used once.</p>
          </div>

          <p style="font-size: 13px; color: #9ca3af; margin-top: 32px; border-top: 1px solid #f3f4f6; padding-top: 16px;">
            IBEQA · International Board for Education Quality Assurance<br/>
            If you did not expect this invitation, you can safely ignore this email.
          </p>
        </div>
      </div>
    `,
  })

  if (emailError) {
    console.error('Email error:', emailError)
    return NextResponse.json({ error: 'User created but invitation email failed to send.' }, { status: 500 })
  }

  return NextResponse.json({ ok: true })
}
