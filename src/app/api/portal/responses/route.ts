import { NextRequest, NextResponse } from 'next/server'
import { createClient } from '@supabase/supabase-js'
import { createClient as createServerClient } from '@/lib/supabase/server'

const supabaseAdmin = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL!,
  process.env.SUPABASE_SERVICE_ROLE_KEY!,
  { auth: { autoRefreshToken: false, persistSession: false } }
)

export async function POST(request: NextRequest) {
  // Verify the user is authenticated
  const supabase = await createServerClient()
  const { data: { user } } = await supabase.auth.getUser()
  if (!user) return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })

  const { institution_id, criteria_id, response_text, evidence_notes } = await request.json()

  // Verify the institution_id matches the user's institution
  if (user.user_metadata?.institution_id !== institution_id) {
    return NextResponse.json({ error: 'Forbidden' }, { status: 403 })
  }

  const { error } = await supabaseAdmin
    .from('application_responses')
    .upsert(
      {
        institution_id,
        criteria_id,
        response_text: response_text || null,
        evidence_notes: evidence_notes || null,
        updated_by: user.id,
        updated_at: new Date().toISOString(),
      },
      { onConflict: 'institution_id,criteria_id' }
    )

  if (error) {
    console.error('Save response error:', error)
    return NextResponse.json({ error: error.message }, { status: 500 })
  }

  return NextResponse.json({ ok: true })
}
