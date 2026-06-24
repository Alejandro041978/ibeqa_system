'use client'

import { useState } from 'react'
import Image from 'next/image'

type Result = {
  approved: boolean
  reasons: string[]
  message: string
}

export default function ApplyPage() {
  const [loading, setLoading] = useState(false)
  const [result, setResult] = useState<Result | null>(null)
  const [form, setForm] = useState({
    institution_name: '',
    country: '',
    founded_year: '',
    student_count: '',
    program_count: '',
    has_official_recognition: '',
    website: '',
    contact_name: '',
    contact_email: '',
    description: '',
  })

  function handleChange(e: React.ChangeEvent<HTMLInputElement | HTMLSelectElement | HTMLTextAreaElement>) {
    setForm(prev => ({ ...prev, [e.target.name]: e.target.value }))
  }

  async function handleSubmit(e: React.FormEvent) {
    e.preventDefault()
    setLoading(true)
    setResult(null)

    try {
      const res = await fetch('/api/apply', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(form),
      })
      const data = await res.json()
      setResult(data)
    } catch {
      setResult({ approved: false, reasons: ['An unexpected error occurred. Please try again.'], message: '' })
    } finally {
      setLoading(false)
    }
  }

  return (
    <div className="min-h-screen bg-gray-50">
      {/* Header */}
      <header className="bg-[#1B2B5E] text-white py-5 px-6">
        <div className="max-w-3xl mx-auto flex items-center gap-3">
          <div className="w-10 h-10 bg-white rounded-lg flex items-center justify-center">
            <span className="text-[#1B2B5E] font-bold text-sm">IB</span>
          </div>
          <div>
            <div className="font-bold text-lg leading-tight">IBEQA</div>
            <div className="text-xs text-blue-200">International Board for Education Quality Assurance</div>
          </div>
        </div>
      </header>

      <main className="max-w-3xl mx-auto py-10 px-4">
        {result ? (
          <div className={`rounded-2xl border-2 p-8 text-center ${result.approved ? 'bg-green-50 border-green-200' : 'bg-red-50 border-red-200'}`}>
            <div className={`w-16 h-16 rounded-full flex items-center justify-center mx-auto mb-4 ${result.approved ? 'bg-green-100' : 'bg-red-100'}`}>
              {result.approved ? (
                <svg className="w-8 h-8 text-green-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M5 13l4 4L19 7" />
                </svg>
              ) : (
                <svg className="w-8 h-8 text-red-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M6 18L18 6M6 6l12 12" />
                </svg>
              )}
            </div>

            <h2 className={`text-2xl font-bold mb-2 ${result.approved ? 'text-green-800' : 'text-red-800'}`}>
              {result.approved ? 'Application Pre-Approved!' : 'Application Not Eligible'}
            </h2>

            <p className={`text-sm mb-6 ${result.approved ? 'text-green-700' : 'text-red-700'}`}>
              {result.message}
            </p>

            {result.reasons.length > 0 && (
              <ul className={`text-sm text-left rounded-xl p-4 space-y-2 ${result.approved ? 'bg-green-100 text-green-800' : 'bg-red-100 text-red-800'}`}>
                {result.reasons.map((r, i) => (
                  <li key={i} className="flex items-start gap-2">
                    <span className="mt-0.5">•</span>
                    <span>{r}</span>
                  </li>
                ))}
              </ul>
            )}

            {!result.approved && (
              <button
                onClick={() => setResult(null)}
                className="mt-6 text-sm text-gray-500 underline hover:text-gray-700"
              >
                Edit and resubmit
              </button>
            )}
          </div>
        ) : (
          <>
            <div className="mb-8 text-center">
              <h1 className="text-3xl font-bold text-gray-900 mb-2">Apply for Accreditation</h1>
              <p className="text-gray-500 text-sm max-w-lg mx-auto">
                Complete this short form to determine your institution&apos;s eligibility for the IBEQA accreditation process. Our AI evaluator will review your information and respond immediately.
              </p>
            </div>

            <form onSubmit={handleSubmit} className="bg-white rounded-2xl border border-gray-200 shadow-sm p-8 space-y-8">
              {/* Institution Information */}
              <section>
                <h2 className="text-xs font-semibold text-gray-500 uppercase tracking-widest mb-4">Institution Information</h2>
                <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                  <div className="md:col-span-2">
                    <label className="block text-sm font-medium text-gray-700 mb-1">
                      Institution Name <span className="text-red-500">*</span>
                    </label>
                    <input
                      name="institution_name" required value={form.institution_name} onChange={handleChange}
                      placeholder="University of..."
                      className="w-full px-3 py-2.5 border border-gray-300 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-[#1B2B5E] focus:border-transparent"
                    />
                  </div>
                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-1">
                      Country <span className="text-red-500">*</span>
                    </label>
                    <input
                      name="country" required value={form.country} onChange={handleChange}
                      placeholder="e.g. United States"
                      className="w-full px-3 py-2.5 border border-gray-300 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-[#1B2B5E] focus:border-transparent"
                    />
                  </div>
                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-1">
                      Year Founded <span className="text-red-500">*</span>
                    </label>
                    <input
                      name="founded_year" required type="number" value={form.founded_year} onChange={handleChange}
                      placeholder="e.g. 1985" min="1800" max="2023"
                      className="w-full px-3 py-2.5 border border-gray-300 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-[#1B2B5E] focus:border-transparent"
                    />
                  </div>
                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-1">
                      Active Students <span className="text-red-500">*</span>
                    </label>
                    <input
                      name="student_count" required type="number" value={form.student_count} onChange={handleChange}
                      placeholder="e.g. 5000" min="0"
                      className="w-full px-3 py-2.5 border border-gray-300 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-[#1B2B5E] focus:border-transparent"
                    />
                  </div>
                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-1">
                      Degree Programs Offered <span className="text-red-500">*</span>
                    </label>
                    <input
                      name="program_count" required type="number" value={form.program_count} onChange={handleChange}
                      placeholder="e.g. 12" min="0"
                      className="w-full px-3 py-2.5 border border-gray-300 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-[#1B2B5E] focus:border-transparent"
                    />
                  </div>
                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-1">
                      Official Government Recognition <span className="text-red-500">*</span>
                    </label>
                    <select
                      name="has_official_recognition" required value={form.has_official_recognition} onChange={handleChange}
                      className="w-full px-3 py-2.5 border border-gray-300 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-[#1B2B5E] focus:border-transparent bg-white"
                    >
                      <option value="">Select an option</option>
                      <option value="yes">Yes — officially recognized</option>
                      <option value="no">No — not yet recognized</option>
                      <option value="pending">In process of recognition</option>
                    </select>
                  </div>
                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-1">Website</label>
                    <input
                      name="website" type="url" value={form.website} onChange={handleChange}
                      placeholder="https://..."
                      className="w-full px-3 py-2.5 border border-gray-300 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-[#1B2B5E] focus:border-transparent"
                    />
                  </div>
                  <div className="md:col-span-2">
                    <label className="block text-sm font-medium text-gray-700 mb-1">
                      Brief Description <span className="text-red-500">*</span>
                    </label>
                    <textarea
                      name="description" required value={form.description} onChange={handleChange}
                      rows={3}
                      placeholder="Briefly describe your institution's mission, academic focus, and any quality assurance efforts already in place..."
                      className="w-full px-3 py-2.5 border border-gray-300 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-[#1B2B5E] focus:border-transparent resize-none"
                    />
                  </div>
                </div>
              </section>

              {/* Contact Information */}
              <section>
                <h2 className="text-xs font-semibold text-gray-500 uppercase tracking-widest mb-4">Primary Contact</h2>
                <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-1">
                      Full Name <span className="text-red-500">*</span>
                    </label>
                    <input
                      name="contact_name" required value={form.contact_name} onChange={handleChange}
                      placeholder="Dr. Jane Smith"
                      className="w-full px-3 py-2.5 border border-gray-300 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-[#1B2B5E] focus:border-transparent"
                    />
                  </div>
                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-1">
                      Institutional Email <span className="text-red-500">*</span>
                    </label>
                    <input
                      name="contact_email" required type="email" value={form.contact_email} onChange={handleChange}
                      placeholder="rector@university.edu"
                      className="w-full px-3 py-2.5 border border-gray-300 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-[#1B2B5E] focus:border-transparent"
                    />
                  </div>
                </div>
              </section>

              <div className="pt-2">
                <button
                  type="submit" disabled={loading}
                  className="w-full bg-[#1B2B5E] text-white py-3 rounded-xl text-sm font-semibold hover:bg-[#162449] transition-colors disabled:opacity-60 disabled:cursor-not-allowed"
                >
                  {loading ? (
                    <span className="flex items-center justify-center gap-2">
                      <svg className="animate-spin h-4 w-4" viewBox="0 0 24 24" fill="none">
                        <circle className="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="4" />
                        <path className="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8v8z" />
                      </svg>
                      Evaluating your application...
                    </span>
                  ) : 'Submit Application'}
                </button>
                <p className="text-center text-xs text-gray-400 mt-3">
                  Your information is reviewed by our AI evaluator. If approved, you will receive an access link by email.
                </p>
              </div>
            </form>
          </>
        )}
      </main>
    </div>
  )
}
