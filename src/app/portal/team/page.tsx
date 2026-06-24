import { createClient } from '@/lib/supabase/server'
import { createClient as createAdminClient } from '@supabase/supabase-js'
import { redirect } from 'next/navigation'
import InviteForm from './InviteForm'
import { Crown, User, Clock, CheckCircle2 } from 'lucide-react'

const supabaseAdmin = createAdminClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL!,
  process.env.SUPABASE_SERVICE_ROLE_KEY!,
  { auth: { autoRefreshToken: false, persistSession: false } }
)

export default async function TeamPage() {
  const supabase = await createClient()
  const { data: { user } } = await supabase.auth.getUser()

  const role = user?.user_metadata?.role
  const institutionId = user?.user_metadata?.institution_id
  const isAdmin = role === 'institution_admin'

  // Only admins can access this page
  if (!isAdmin) redirect('/portal')

  // Fetch all users belonging to this institution
  const { data: { users: allUsers } } = await supabaseAdmin.auth.admin.listUsers()
  const members = allUsers
    .filter(u => u.user_metadata?.institution_id === institutionId)
    .sort((a, b) => {
      // Admin first, then by created_at
      if (a.user_metadata?.role === 'institution_admin') return -1
      if (b.user_metadata?.role === 'institution_admin') return 1
      return new Date(a.created_at).getTime() - new Date(b.created_at).getTime()
    })

  return (
    <div className="p-8 max-w-3xl">
      <div className="mb-8">
        <h1 className="text-2xl font-bold text-gray-900">Team</h1>
        <p className="text-gray-500 mt-1 text-sm">
          Invite colleagues to help complete your accreditation application. Each member can be assigned specific components.
        </p>
      </div>

      {/* Invite form */}
      <div className="bg-white rounded-xl border border-gray-200 p-6 mb-6">
        <h2 className="text-sm font-semibold text-gray-800 mb-4">Invite a team member</h2>
        <InviteForm institutionId={institutionId} />
      </div>

      {/* Members list */}
      <div className="bg-white rounded-xl border border-gray-200 overflow-hidden">
        <div className="px-6 py-4 border-b border-gray-100 flex items-center justify-between">
          <h2 className="text-sm font-semibold text-gray-800">Members</h2>
          <span className="text-xs text-gray-400 bg-gray-100 px-2 py-1 rounded-full">{members.length} {members.length === 1 ? 'member' : 'members'}</span>
        </div>

        <div className="divide-y divide-gray-50">
          {members.map((member) => {
            const isCurrentUser = member.id === user?.id
            const memberRole = member.user_metadata?.role
            const isConfirmed = !!member.email_confirmed_at
            const lastSignIn = member.last_sign_in_at
              ? new Date(member.last_sign_in_at).toLocaleDateString('en-GB', { day: 'numeric', month: 'short', year: 'numeric' })
              : null

            return (
              <div key={member.id} className="px-6 py-4 flex items-center justify-between">
                <div className="flex items-center gap-3">
                  <div className={`w-9 h-9 rounded-full flex items-center justify-center text-sm font-semibold flex-shrink-0 ${
                    memberRole === 'institution_admin' ? 'bg-[#1B2B5E] text-white' : 'bg-gray-100 text-gray-600'
                  }`}>
                    {(member.user_metadata?.full_name ?? member.email ?? '?')[0].toUpperCase()}
                  </div>
                  <div>
                    <div className="flex items-center gap-2">
                      <p className="text-sm font-medium text-gray-900">
                        {member.user_metadata?.full_name ?? '—'}
                      </p>
                      {isCurrentUser && (
                        <span className="text-xs text-gray-400">(you)</span>
                      )}
                    </div>
                    <p className="text-xs text-gray-400">{member.email}</p>
                  </div>
                </div>

                <div className="flex items-center gap-4">
                  {lastSignIn ? (
                    <span className="text-xs text-gray-400 hidden sm:block">Last login: {lastSignIn}</span>
                  ) : (
                    <span className="text-xs text-amber-500 flex items-center gap-1 hidden sm:flex">
                      <Clock size={11} /> Invitation pending
                    </span>
                  )}

                  <div className={`flex items-center gap-1.5 px-2.5 py-1 rounded-full text-xs font-medium ${
                    memberRole === 'institution_admin'
                      ? 'bg-[#1B2B5E]/10 text-[#1B2B5E]'
                      : 'bg-gray-100 text-gray-600'
                  }`}>
                    {memberRole === 'institution_admin' ? (
                      <><Crown size={11} /> Admin</>
                    ) : (
                      <><User size={11} /> Member</>
                    )}
                  </div>
                </div>
              </div>
            )
          })}
        </div>
      </div>

      {/* Info note */}
      <p className="text-xs text-gray-400 mt-4">
        Invited members will receive a magic link by email. They will be able to view and edit all application components.
      </p>
    </div>
  )
}
