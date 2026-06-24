import { createClient } from '@/lib/supabase/server'
import { createClient as createAdminClient } from '@supabase/supabase-js'
import { notFound } from 'next/navigation'
import Link from 'next/link'
import { ArrowLeft, CheckCircle2, Circle } from 'lucide-react'
import ComponentForm from './ComponentForm'

const supabaseAdmin = createAdminClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL!,
  process.env.SUPABASE_SERVICE_ROLE_KEY!,
  { auth: { autoRefreshToken: false, persistSession: false } }
)

export default async function ComponentPage({ params }: { params: Promise<{ component: string }> }) {
  const { component: componentSlug } = await params

  const supabase = await createClient()
  const { data: { user } } = await supabase.auth.getUser()
  const institutionId = user?.user_metadata?.institution_id

  // Find component by code (slug is lowercase code like 'c01')
  const { data: component } = await supabaseAdmin
    .from('components')
    .select('id, code, name, weight, sort_order, factors(id, code, name, sort_order, criteria(id, code, name, sort_order))')
    .ilike('code', componentSlug)
    .single()

  if (!component) notFound()

  // Sort factors and criteria
  const factors = (component.factors as Array<{
    id: string; code: string; name: string; sort_order: number
    criteria: Array<{ id: string; code: string; name: string; sort_order: number }>
  }>).sort((a, b) => a.sort_order - b.sort_order).map(f => ({
    ...f,
    criteria: [...f.criteria].sort((a, b) => a.sort_order - b.sort_order)
  }))

  // Load existing responses for this institution
  const criteriaIds = factors.flatMap(f => f.criteria.map(c => c.id))
  const { data: responses } = institutionId && criteriaIds.length > 0
    ? await supabaseAdmin
        .from('application_responses')
        .select('criteria_id, response_text, evidence_notes, updated_at')
        .eq('institution_id', institutionId)
        .in('criteria_id', criteriaIds)
    : { data: [] }

  const responseMap: Record<string, { response_text: string; evidence_notes: string }> = {}
  for (const r of (responses ?? [])) {
    responseMap[r.criteria_id] = { response_text: r.response_text ?? '', evidence_notes: r.evidence_notes ?? '' }
  }

  const totalCriteria = criteriaIds.length
  const answeredCriteria = Object.values(responseMap).filter(r => r.response_text?.trim()).length
  const pct = totalCriteria > 0 ? Math.round((answeredCriteria / totalCriteria) * 100) : 0

  return (
    <div className="p-8 max-w-4xl">
      {/* Back */}
      <Link href="/portal/application" className="inline-flex items-center gap-1.5 text-sm text-gray-500 hover:text-gray-800 mb-6 transition-colors">
        <ArrowLeft size={14} />
        Back to Application
      </Link>

      {/* Header */}
      <div className="mb-6">
        <p className="text-xs font-semibold text-gray-400 uppercase tracking-wide mb-1">{component.code}</p>
        <h1 className="text-2xl font-bold text-gray-900">{component.name}</h1>
        <p className="text-sm text-gray-500 mt-1">
          {factors.length} factors · {totalCriteria} criteria · Weight: {component.weight}%
        </p>
      </div>

      {/* Progress bar */}
      <div className="bg-white rounded-xl border border-gray-200 p-5 mb-8">
        <div className="flex items-center justify-between mb-2">
          <p className="text-sm font-medium text-gray-700">Component Progress</p>
          <span className={`text-sm font-bold ${pct === 100 ? 'text-green-600' : 'text-[#1B2B5E]'}`}>{pct}%</span>
        </div>
        <div className="w-full bg-gray-100 rounded-full h-2">
          <div
            className={`h-2 rounded-full transition-all ${pct === 100 ? 'bg-green-500' : 'bg-[#1B2B5E]'}`}
            style={{ width: `${pct}%` }}
          />
        </div>
        <p className="text-xs text-gray-400 mt-2">{answeredCriteria} of {totalCriteria} criteria completed</p>
      </div>

      {/* Factors with criteria forms */}
      <ComponentForm
        institutionId={institutionId ?? ''}
        factors={factors}
        initialResponses={responseMap}
      />
    </div>
  )
}
