import { createClient } from '@/lib/supabase/server'
import { createClient as createAdminClient } from '@supabase/supabase-js'
import Link from 'next/link'
import { CheckCircle2, Circle, ChevronRight, Lock } from 'lucide-react'

const supabaseAdmin = createAdminClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL!,
  process.env.SUPABASE_SERVICE_ROLE_KEY!,
  { auth: { autoRefreshToken: false, persistSession: false } }
)

export default async function ApplicationPage() {
  const supabase = await createClient()
  const { data: { user } } = await supabase.auth.getUser()
  const institutionId = user?.user_metadata?.institution_id

  const { data: components } = await supabaseAdmin
    .from('components')
    .select('id, code, name, weight, sort_order, factors(id, code, name, sort_order, criteria(id))')
    .order('sort_order')

  const { data: answers } = institutionId
    ? await supabaseAdmin
        .from('application_responses')
        .select('criteria_id')
        .eq('institution_id', institutionId)
        .not('response_text', 'is', null)
    : { data: [] }

  const answeredSet = new Set((answers ?? []).map((a: { criteria_id: string }) => a.criteria_id))

  const componentStats = (components ?? []).map((c: {
    id: string
    code: string
    name: string
    weight: number
    sort_order: number
    factors: Array<{ id: string; code: string; name: string; sort_order: number; criteria: Array<{ id: string }> }>
  }) => {
    const totalCriteria = c.factors.reduce((sum: number, f) => sum + f.criteria.length, 0)
    const answeredCriteria = c.factors.reduce(
      (sum: number, f) => sum + f.criteria.filter((cr) => answeredSet.has(cr.id)).length,
      0
    )
    const pct = totalCriteria > 0 ? Math.round((answeredCriteria / totalCriteria) * 100) : 0
    return { ...c, totalCriteria, answeredCriteria, pct }
  })

  const totalAll = componentStats.reduce((s, c) => s + c.totalCriteria, 0)
  const answeredAll = componentStats.reduce((s, c) => s + c.answeredCriteria, 0)
  const overallPct = totalAll > 0 ? Math.round((answeredAll / totalAll) * 100) : 0

  return (
    <div className="p-8 max-w-5xl">
      <div className="mb-8">
        <h1 className="text-2xl font-bold text-gray-900">Accreditation Application</h1>
        <p className="text-gray-500 mt-1 text-sm">
          Complete all 12 components of the MIAC-U model. You can work on them in any order and save progress at any time.
        </p>
      </div>

      {/* Overall progress */}
      <div className="bg-white rounded-xl border border-gray-200 p-6 mb-8">
        <div className="flex items-center justify-between mb-3">
          <div>
            <p className="text-sm font-semibold text-gray-700">Overall Progress</p>
            <p className="text-xs text-gray-400 mt-0.5">{answeredAll} of {totalAll} criteria completed</p>
          </div>
          <span className="text-2xl font-bold text-[#1B2B5E]">{overallPct}%</span>
        </div>
        <div className="w-full bg-gray-100 rounded-full h-3">
          <div
            className="bg-[#1B2B5E] h-3 rounded-full transition-all"
            style={{ width: `${overallPct}%` }}
          />
        </div>
      </div>

      {/* Component grid */}
      <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
        {componentStats.map((c) => {
          const isComplete = c.pct === 100
          const isStarted = c.pct > 0
          return (
            <Link
              key={c.id}
              href={`/portal/application/${c.code.toLowerCase()}`}
              className="bg-white rounded-xl border border-gray-200 p-5 hover:border-[#1B2B5E] hover:shadow-sm transition-all group"
            >
              <div className="flex items-start justify-between mb-4">
                <div className="flex items-start gap-3">
                  <div className={`mt-0.5 flex-shrink-0 ${isComplete ? 'text-green-500' : 'text-gray-300'}`}>
                    {isComplete ? <CheckCircle2 size={20} /> : <Circle size={20} />}
                  </div>
                  <div>
                    <p className="text-xs font-semibold text-gray-400 uppercase tracking-wide">{c.code}</p>
                    <h3 className="text-sm font-semibold text-gray-900 mt-0.5 leading-snug">{c.name}</h3>
                  </div>
                </div>
                <ChevronRight size={16} className="text-gray-300 group-hover:text-[#1B2B5E] flex-shrink-0 mt-1 transition-colors" />
              </div>

              <div className="flex items-center justify-between mb-2">
                <span className="text-xs text-gray-400">
                  {c.answeredCriteria}/{c.totalCriteria} criteria · {c.factors.length} factors
                </span>
                <span className={`text-xs font-semibold ${isComplete ? 'text-green-600' : isStarted ? 'text-blue-600' : 'text-gray-400'}`}>
                  {isComplete ? 'Complete' : isStarted ? `${c.pct}%` : 'Not started'}
                </span>
              </div>

              <div className="w-full bg-gray-100 rounded-full h-1.5">
                <div
                  className={`h-1.5 rounded-full transition-all ${isComplete ? 'bg-green-500' : 'bg-[#1B2B5E]'}`}
                  style={{ width: `${c.pct}%` }}
                />
              </div>

              <div className="mt-3 flex items-center gap-1.5">
                <span className="text-xs text-gray-400">Weight:</span>
                <span className="text-xs font-semibold text-gray-600">{c.weight}%</span>
                {!isStarted && (
                  <span className="ml-auto text-xs text-gray-400 flex items-center gap-1">
                    <Lock size={10} />
                    Start filling
                  </span>
                )}
              </div>
            </Link>
          )
        })}
      </div>
    </div>
  )
}
