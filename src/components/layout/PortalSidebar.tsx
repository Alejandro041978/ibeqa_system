'use client'

import Link from 'next/link'
import { usePathname } from 'next/navigation'
import {
  LayoutDashboard,
  FileText,
  Users,
  CreditCard,
  Settings,
  LogOut,
} from 'lucide-react'
import { createClient } from '@/lib/supabase/client'
import { useRouter } from 'next/navigation'

const navItems = [
  { href: '/portal', label: 'Overview', icon: LayoutDashboard },
  { href: '/portal/application', label: 'My Application', icon: FileText },
  { href: '/portal/team', label: 'Team', icon: Users },
  { href: '/portal/payments', label: 'Payments', icon: CreditCard },
  { href: '/portal/settings', label: 'Settings', icon: Settings },
]

export default function PortalSidebar({ institutionName }: { institutionName?: string }) {
  const pathname = usePathname()
  const router = useRouter()

  async function handleSignOut() {
    const supabase = createClient()
    await supabase.auth.signOut()
    router.push('/login')
    router.refresh()
  }

  return (
    <aside className="w-64 bg-[#1B2B5E] flex flex-col">
      <div className="px-6 py-6 border-b border-white/10">
        <h1 className="text-white font-bold text-xl tracking-wide">IBEQA</h1>
        <p className="text-white/50 text-xs mt-0.5 truncate">{institutionName ?? 'Institution Portal'}</p>
      </div>

      <nav className="flex-1 px-3 py-4 space-y-0.5">
        {navItems.map(({ href, label, icon: Icon }) => {
          const active = pathname === href || (href !== '/portal' && pathname.startsWith(href))
          return (
            <Link
              key={href}
              href={href}
              className={`flex items-center gap-3 px-3 py-2.5 rounded-lg text-sm transition-colors ${
                active
                  ? 'bg-white/15 text-white font-medium'
                  : 'text-white/60 hover:bg-white/10 hover:text-white'
              }`}
            >
              <Icon size={18} />
              {label}
            </Link>
          )
        })}
      </nav>

      <div className="px-3 py-4 border-t border-white/10">
        <button
          onClick={handleSignOut}
          className="flex items-center gap-3 px-3 py-2.5 rounded-lg text-sm text-white/60 hover:bg-white/10 hover:text-white transition-colors w-full"
        >
          <LogOut size={18} />
          Sign out
        </button>
      </div>
    </aside>
  )
}
