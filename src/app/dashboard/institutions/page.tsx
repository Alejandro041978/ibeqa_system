import { createClient } from '@/lib/supabase/server'
import Link from 'next/link'
import { Building2, Plus, Globe, Users } from 'lucide-react'

export default async function InstitutionsPage() {
  const supabase = await createClient()
  const { data: institutions } = await supabase
    .from('institutions')
    .select('*')
    .order('created_at', { ascending: false })

  return (
    <div className="p-8">
      <div className="flex items-center justify-between mb-8">
        <div>
          <h1 className="text-2xl font-bold text-gray-900">Institutions</h1>
          <p className="text-gray-500 mt-1 text-sm">Manage accredited and applicant institutions</p>
        </div>
        <Link
          href="/dashboard/institutions/new"
          className="flex items-center gap-2 bg-[#1B2B5E] text-white px-4 py-2.5 rounded-lg text-sm font-medium hover:bg-[#162449] transition-colors"
        >
          <Plus size={16} />
          Add Institution
        </Link>
      </div>

      {!institutions || institutions.length === 0 ? (
        <div className="bg-white rounded-xl border border-gray-200 p-16 text-center">
          <Building2 size={40} className="text-gray-300 mx-auto mb-4" />
          <h3 className="text-gray-600 font-medium mb-1">No institutions yet</h3>
          <p className="text-gray-400 text-sm mb-6">Add the first institution to start managing accreditations.</p>
          <Link
            href="/dashboard/institutions/new"
            className="inline-flex items-center gap-2 bg-[#1B2B5E] text-white px-4 py-2.5 rounded-lg text-sm font-medium hover:bg-[#162449] transition-colors"
          >
            <Plus size={16} />
            Add Institution
          </Link>
        </div>
      ) : (
        <div className="grid grid-cols-1 md:grid-cols-2 xl:grid-cols-3 gap-5">
          {institutions.map((inst) => (
            <Link
              key={inst.id}
              href={`/dashboard/institutions/${inst.id}`}
              className="bg-white rounded-xl border border-gray-200 p-6 hover:border-[#1B2B5E] hover:shadow-sm transition-all"
            >
              <div className="flex items-start gap-4 mb-4">
                <div className="w-12 h-12 bg-blue-50 rounded-lg flex items-center justify-center flex-shrink-0">
                  <Building2 size={22} className="text-[#1B2B5E]" />
                </div>
                <div className="min-w-0">
                  <h3 className="font-semibold text-gray-900 truncate">{inst.name}</h3>
                  <p className="text-sm text-gray-500">{inst.country}{inst.city ? `, ${inst.city}` : ''}</p>
                </div>
              </div>
              <div className="flex items-center gap-4 text-xs text-gray-400">
                {inst.website && (
                  <span className="flex items-center gap-1">
                    <Globe size={12} />
                    {inst.website.replace('https://', '').replace('http://', '')}
                  </span>
                )}
                {inst.student_count && (
                  <span className="flex items-center gap-1">
                    <Users size={12} />
                    {inst.student_count.toLocaleString()} students
                  </span>
                )}
              </div>
              <div className="mt-4 pt-4 border-t border-gray-100 flex items-center justify-between">
                <span className={`text-xs px-2 py-1 rounded-full font-medium ${
                  inst.size === 'large' ? 'bg-blue-50 text-blue-700' :
                  inst.size === 'medium' ? 'bg-amber-50 text-amber-700' :
                  'bg-gray-50 text-gray-600'
                }`}>
                  {inst.size?.charAt(0).toUpperCase() + inst.size?.slice(1)}
                </span>
                <span className={`text-xs px-2 py-1 rounded-full font-medium ${
                  inst.is_active ? 'bg-green-50 text-green-700' : 'bg-red-50 text-red-700'
                }`}>
                  {inst.is_active ? 'Active' : 'Inactive'}
                </span>
              </div>
            </Link>
          ))}
        </div>
      )}
    </div>
  )
}
