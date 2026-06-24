'use client'

import { useState } from 'react'
import { UserPlus, Loader2, CheckCircle2, AlertCircle } from 'lucide-react'

export default function InviteForm({ institutionId }: { institutionId?: string }) {
  const [fullName, setFullName] = useState('')
  const [email, setEmail] = useState('')
  const [status, setStatus] = useState<'idle' | 'loading' | 'success' | 'error'>('idle')
  const [message, setMessage] = useState('')

  async function handleSubmit(e: React.FormEvent) {
    e.preventDefault()
    if (!fullName.trim() || !email.trim()) return

    setStatus('loading')
    setMessage('')

    try {
      const res = await fetch('/api/portal/invite', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ full_name: fullName.trim(), email: email.trim(), institution_id: institutionId }),
      })
      const data = await res.json()

      if (!res.ok) {
        setStatus('error')
        setMessage(data.error ?? 'Something went wrong. Please try again.')
      } else {
        setStatus('success')
        setMessage(`Invitation sent to ${email}. They will receive a magic link to access the portal.`)
        setFullName('')
        setEmail('')
      }
    } catch {
      setStatus('error')
      setMessage('Network error. Please check your connection and try again.')
    }
  }

  return (
    <form onSubmit={handleSubmit} className="space-y-4">
      <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
        <div>
          <label className="block text-xs font-semibold text-gray-500 mb-1.5">Full name</label>
          <input
            type="text"
            required
            placeholder="Jane Smith"
            value={fullName}
            onChange={e => setFullName(e.target.value)}
            className="w-full text-sm border border-gray-200 rounded-lg px-3 py-2.5 focus:outline-none focus:ring-2 focus:ring-[#1B2B5E]/20 focus:border-[#1B2B5E] placeholder:text-gray-300"
          />
        </div>
        <div>
          <label className="block text-xs font-semibold text-gray-500 mb-1.5">Institutional email</label>
          <input
            type="email"
            required
            placeholder="jane@yourinstitution.edu"
            value={email}
            onChange={e => setEmail(e.target.value)}
            className="w-full text-sm border border-gray-200 rounded-lg px-3 py-2.5 focus:outline-none focus:ring-2 focus:ring-[#1B2B5E]/20 focus:border-[#1B2B5E] placeholder:text-gray-300"
          />
        </div>
      </div>

      <div className="flex items-center gap-3">
        <button
          type="submit"
          disabled={status === 'loading' || !fullName.trim() || !email.trim()}
          className="inline-flex items-center gap-2 bg-[#1B2B5E] text-white text-sm font-medium px-4 py-2.5 rounded-lg hover:bg-[#162347] transition-colors disabled:opacity-50 disabled:cursor-not-allowed"
        >
          {status === 'loading' ? (
            <><Loader2 size={15} className="animate-spin" /> Sending invitation...</>
          ) : (
            <><UserPlus size={15} /> Send invitation</>
          )}
        </button>

        {status === 'success' && (
          <span className="text-sm text-green-600 flex items-center gap-1.5">
            <CheckCircle2 size={15} /> {message}
          </span>
        )}
        {status === 'error' && (
          <span className="text-sm text-red-500 flex items-center gap-1.5">
            <AlertCircle size={15} /> {message}
          </span>
        )}
      </div>
    </form>
  )
}
