'use client'

import { useState } from 'react'
import { createClient } from '@/lib/supabase/client'

type Step = 'email' | 'sent'

export default function LoginPage() {
  const [email, setEmail] = useState('')
  const [step, setStep] = useState<Step>('email')
  const [error, setError] = useState('')
  const [loading, setLoading] = useState(false)

  async function handleSubmit(e: React.FormEvent) {
    e.preventDefault()
    setLoading(true)
    setError('')

    const supabase = createClient()
    const { error } = await supabase.auth.signInWithOtp({
      email,
      options: {
        shouldCreateUser: false,
      },
    })

    if (error) {
      setError('This email is not registered. Please contact IBEQA.')
      setLoading(false)
      return
    }

    setStep('sent')
    setLoading(false)
  }

  return (
    <div className="min-h-screen bg-gray-50 flex items-center justify-center px-4">
      <div className="w-full max-w-md">
        <div className="text-center mb-8">
          <h1 className="text-3xl font-bold text-[#1B2B5E]">IBEQA</h1>
          <p className="text-gray-500 mt-1 text-sm">International Board for Education Quality Assurance</p>
        </div>

        <div className="bg-white rounded-xl shadow-sm border border-gray-200 p-8">
          {step === 'email' ? (
            <>
              <h2 className="text-xl font-semibold text-gray-800 mb-2">Sign in</h2>
              <p className="text-sm text-gray-500 mb-6">Enter your email and we&apos;ll send you a secure access link.</p>

              <form onSubmit={handleSubmit} className="space-y-4">
                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-1">Email address</label>
                  <input
                    type="email"
                    required
                    value={email}
                    onChange={e => setEmail(e.target.value)}
                    className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-[#1B2B5E] focus:border-transparent"
                    placeholder="you@institution.edu"
                  />
                </div>

                {error && (
                  <p className="text-sm text-red-600 bg-red-50 px-3 py-2 rounded-lg">{error}</p>
                )}

                <button
                  type="submit"
                  disabled={loading}
                  className="w-full bg-[#1B2B5E] text-white py-2.5 rounded-lg text-sm font-medium hover:bg-[#162449] transition-colors disabled:opacity-50"
                >
                  {loading ? 'Sending...' : 'Send access link'}
                </button>
              </form>

              <p className="text-center text-sm text-gray-400 mt-6">
                Don&apos;t have access?{' '}
                <a href="mailto:admin@ibeqa.org" className="text-[#1B2B5E] font-medium hover:underline">
                  Contact IBEQA
                </a>
              </p>
            </>
          ) : (
            <div className="text-center py-4">
              <div className="w-14 h-14 bg-green-50 rounded-full flex items-center justify-center mx-auto mb-4">
                <svg className="w-7 h-7 text-green-500" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M3 8l7.89 5.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z" />
                </svg>
              </div>
              <h2 className="text-xl font-semibold text-gray-800 mb-2">Check your email</h2>
              <p className="text-sm text-gray-500 mb-1">We sent a secure access link to:</p>
              <p className="text-sm font-medium text-[#1B2B5E] mb-6">{email}</p>
              <p className="text-xs text-gray-400">Click the link in the email to sign in. The link expires in 1 hour.</p>
              <button
                onClick={() => { setStep('email'); setError('') }}
                className="mt-6 text-sm text-[#1B2B5E] hover:underline"
              >
                Use a different email
              </button>
            </div>
          )}
        </div>
      </div>
    </div>
  )
}
