import { NextRequest, NextResponse } from 'next/server'
import { createClient as createAdminClient } from '@supabase/supabase-js'
import { createClient as createServerClient } from '@/lib/supabase/server'

const supabaseAdmin = createAdminClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL!,
  process.env.SUPABASE_SERVICE_ROLE_KEY!,
  { auth: { autoRefreshToken: false, persistSession: false } }
)

export async function POST(request: NextRequest) {
  const supabase = await createServerClient()
  const { data: { user } } = await supabase.auth.getUser()
  if (!user) return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })

  const institutionId = user.user_metadata?.institution_id

  const formData = await request.formData()
  const reqInstitutionId = formData.get('institution_id') as string

  if (reqInstitutionId !== institutionId) {
    return NextResponse.json({ error: 'Forbidden' }, { status: 403 })
  }

  const feeType = formData.get('fee_type') as string
  const currency = formData.get('currency') as string
  const amountDeclared = parseFloat(formData.get('amount_declared') as string)
  const transferDate = formData.get('transfer_date') as string
  const bankReference = formData.get('bank_reference') as string
  const payerName = formData.get('payer_name') as string
  const notes = formData.get('notes') as string
  const evidenceFile = formData.get('evidence') as File | null

  if (!feeType || !currency || !amountDeclared || !transferDate || !evidenceFile) {
    return NextResponse.json({ error: 'Missing required fields.' }, { status: 400 })
  }

  // Upload evidence to Supabase Storage
  const fileExt = evidenceFile.name.split('.').pop()
  const fileName = `${institutionId}/${feeType}_${Date.now()}.${fileExt}`
  const fileBuffer = await evidenceFile.arrayBuffer()

  const { error: uploadError } = await supabaseAdmin.storage
    .from('payment-evidence')
    .upload(fileName, fileBuffer, {
      contentType: evidenceFile.type,
      upsert: false,
    })

  if (uploadError) {
    console.error('Upload error:', uploadError)
    return NextResponse.json({ error: 'Failed to upload evidence file.' }, { status: 500 })
  }

  const { data: { publicUrl } } = supabaseAdmin.storage
    .from('payment-evidence')
    .getPublicUrl(fileName)

  // Insert payment record
  const { error: insertError } = await supabaseAdmin
    .from('payments')
    .insert({
      institution_id: institutionId,
      fee_type: feeType,
      currency,
      amount_declared: amountDeclared,
      transfer_date: transferDate,
      bank_reference: bankReference || null,
      payer_name: payerName || null,
      notes: notes || null,
      evidence_url: publicUrl,
      status: 'pending',
      submitted_by: user.id,
    })

  if (insertError) {
    console.error('Insert error:', insertError)
    return NextResponse.json({ error: insertError.message }, { status: 500 })
  }

  return NextResponse.json({ ok: true })
}
