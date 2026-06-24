import { createClient } from '@/lib/supabase/server'

export default async function PortalSettingsPage() {
  const supabase = await createClient()
  const { data: { user } } = await supabase.auth.getUser()

  return (
    <div className="p-8 max-w-2xl">
      <div className="mb-8">
        <h1 className="text-2xl font-bold text-gray-900">Settings</h1>
        <p className="text-gray-500 mt-1 text-sm">Your account information</p>
      </div>

      <div className="bg-white rounded-xl border border-gray-200 p-6 space-y-4">
        <div>
          <label className="block text-xs font-semibold text-gray-500 uppercase tracking-wide mb-1">Full Name</label>
          <p className="text-sm text-gray-800">{user?.user_metadata?.full_name ?? '—'}</p>
        </div>
        <div>
          <label className="block text-xs font-semibold text-gray-500 uppercase tracking-wide mb-1">Email</label>
          <p className="text-sm text-gray-800">{user?.email}</p>
        </div>
        <div>
          <label className="block text-xs font-semibold text-gray-500 uppercase tracking-wide mb-1">Institution</label>
          <p className="text-sm text-gray-800">{user?.user_metadata?.institution_name ?? '—'}</p>
        </div>
        <div>
          <label className="block text-xs font-semibold text-gray-500 uppercase tracking-wide mb-1">Role</label>
          <p className="text-sm text-gray-800">{user?.user_metadata?.role ?? '—'}</p>
        </div>
      </div>
    </div>
  )
}
