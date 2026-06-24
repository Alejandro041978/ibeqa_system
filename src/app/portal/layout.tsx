import { createClient } from '@/lib/supabase/server'
import { redirect } from 'next/navigation'
import PortalSidebar from '@/components/layout/PortalSidebar'

export default async function PortalLayout({ children }: { children: React.ReactNode }) {
  const supabase = await createClient()
  const { data: { user } } = await supabase.auth.getUser()

  if (!user) redirect('/login')

  const role = user.user_metadata?.role
  if (role !== 'institution_admin' && role !== 'institution_user') {
    redirect('/dashboard')
  }

  const institutionName = user.user_metadata?.institution_name

  return (
    <div className="flex h-screen bg-gray-50">
      <PortalSidebar institutionName={institutionName} />
      <main className="flex-1 overflow-auto">
        {children}
      </main>
    </div>
  )
}
