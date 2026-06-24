import { createClient } from '@/lib/supabase/server'
import { Building2, FileText, Award, ClipboardCheck } from 'lucide-react'

const stats = [
  { label: 'Institutions', value: '0', icon: Building2, color: 'bg-blue-50 text-blue-600' },
  { label: 'Applications', value: '0', icon: FileText, color: 'bg-amber-50 text-amber-600' },
  { label: 'In Evaluation', value: '0', icon: ClipboardCheck, color: 'bg-purple-50 text-purple-600' },
  { label: 'Accredited', value: '0', icon: Award, color: 'bg-green-50 text-green-600' },
]

export default async function DashboardPage() {
  const supabase = await createClient()
  const { data: { user } } = await supabase.auth.getUser()

  return (
    <div className="p-8">
      <div className="mb-8">
        <h1 className="text-2xl font-bold text-gray-900">Dashboard</h1>
        <p className="text-gray-500 mt-1 text-sm">Welcome back, {user?.email}</p>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-5 mb-8">
        {stats.map(({ label, value, icon: Icon, color }) => (
          <div key={label} className="bg-white rounded-xl border border-gray-200 p-5">
            <div className="flex items-center justify-between mb-3">
              <span className="text-sm text-gray-500">{label}</span>
              <div className={`p-2 rounded-lg ${color}`}>
                <Icon size={18} />
              </div>
            </div>
            <p className="text-3xl font-bold text-gray-900">{value}</p>
          </div>
        ))}
      </div>

      <div className="bg-white rounded-xl border border-gray-200 p-6">
        <h2 className="text-base font-semibold text-gray-800 mb-4">Recent Activity</h2>
        <p className="text-sm text-gray-400 text-center py-8">No activity yet. Start by adding an institution.</p>
      </div>
    </div>
  )
}
