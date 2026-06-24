import { createClient } from '@/lib/supabase/server'
import { FileText, CheckCircle, Clock, AlertCircle } from 'lucide-react'

const STAGES = [
  { key: 'eligibility', label: 'Eligibility', description: 'Initial screening passed' },
  { key: 'application', label: 'Application', description: 'Complete the 72 evaluation criteria' },
  { key: 'payment', label: 'Preliminary Fee', description: 'Pay the evaluation fee' },
  { key: 'ai_review', label: 'AI Review', description: 'Automated preliminary evaluation' },
  { key: 'site_visit', label: 'Site Visit', description: 'On-site evaluation by IBEQA evaluators' },
  { key: 'accreditation', label: 'Accreditation', description: 'Final decision and certificate issuance' },
]

export default async function PortalPage() {
  const supabase = await createClient()
  const { data: { user } } = await supabase.auth.getUser()

  const institutionName = user?.user_metadata?.institution_name ?? 'Your Institution'
  const contactName = user?.user_metadata?.full_name ?? user?.email

  // Current stage — eligibility is always completed once they're here
  const currentStage = 'application'
  const currentStageIndex = STAGES.findIndex(s => s.key === currentStage)

  return (
    <div className="p-8 max-w-4xl">
      {/* Welcome */}
      <div className="mb-8">
        <h1 className="text-2xl font-bold text-gray-900">Welcome, {contactName}</h1>
        <p className="text-gray-500 mt-1 text-sm">{institutionName} · Accreditation Portal</p>
      </div>

      {/* Status banner */}
      <div className="bg-amber-50 border border-amber-200 rounded-xl p-5 mb-8 flex items-start gap-4">
        <AlertCircle size={20} className="text-amber-500 flex-shrink-0 mt-0.5" />
        <div>
          <p className="text-sm font-semibold text-amber-800">Action required: Complete your application</p>
          <p className="text-sm text-amber-700 mt-0.5">
            Your institution has been approved for the accreditation process. The next step is to fill in all evaluation criteria forms.
          </p>
        </div>
      </div>

      {/* Progress timeline */}
      <div className="bg-white rounded-xl border border-gray-200 p-6 mb-6">
        <h2 className="text-sm font-semibold text-gray-700 uppercase tracking-wide mb-6">Accreditation Progress</h2>
        <div className="space-y-0">
          {STAGES.map((stage, i) => {
            const completed = i < currentStageIndex
            const active = i === currentStageIndex
            const pending = i > currentStageIndex

            return (
              <div key={stage.key} className="flex gap-4">
                {/* Connector */}
                <div className="flex flex-col items-center">
                  <div className={`w-8 h-8 rounded-full flex items-center justify-center flex-shrink-0 ${
                    completed ? 'bg-green-100' : active ? 'bg-[#1B2B5E]' : 'bg-gray-100'
                  }`}>
                    {completed ? (
                      <CheckCircle size={16} className="text-green-600" />
                    ) : active ? (
                      <Clock size={16} className="text-white" />
                    ) : (
                      <span className="text-xs text-gray-400 font-medium">{i + 1}</span>
                    )}
                  </div>
                  {i < STAGES.length - 1 && (
                    <div className={`w-0.5 h-8 mt-1 ${completed ? 'bg-green-200' : 'bg-gray-100'}`} />
                  )}
                </div>

                {/* Label */}
                <div className="pb-8 pt-1">
                  <p className={`text-sm font-medium ${completed ? 'text-green-700' : active ? 'text-[#1B2B5E]' : 'text-gray-400'}`}>
                    {stage.label}
                    {active && <span className="ml-2 text-xs bg-[#1B2B5E] text-white px-2 py-0.5 rounded-full">Current</span>}
                    {completed && <span className="ml-2 text-xs bg-green-100 text-green-700 px-2 py-0.5 rounded-full">Completed</span>}
                  </p>
                  <p className="text-xs text-gray-400 mt-0.5">{stage.description}</p>
                </div>
              </div>
            )
          })}
        </div>
      </div>

      {/* Quick actions */}
      <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
        <a
          href="/portal/application"
          className="bg-[#1B2B5E] text-white rounded-xl p-5 hover:bg-[#162449] transition-colors"
        >
          <FileText size={22} className="mb-3 opacity-80" />
          <p className="font-semibold text-sm">Start Application Forms</p>
          <p className="text-xs text-blue-200 mt-1">Complete the 72 MIAC-U evaluation criteria</p>
        </a>
        <a
          href="/portal/team"
          className="bg-white border border-gray-200 rounded-xl p-5 hover:border-[#1B2B5E] transition-colors"
        >
          <div className="w-6 h-6 mb-3 text-gray-400">
            <svg fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M17 20h5v-2a4 4 0 00-5-5M9 20H4v-2a4 4 0 015-5m6-4a4 4 0 11-8 0 4 4 0 018 0z" />
            </svg>
          </div>
          <p className="font-semibold text-sm text-gray-800">Invite Team Members</p>
          <p className="text-xs text-gray-400 mt-1">Add colleagues to collaborate on the application</p>
        </a>
      </div>
    </div>
  )
}
