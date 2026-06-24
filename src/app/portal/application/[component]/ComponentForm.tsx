'use client'

import { useState, useCallback, useRef } from 'react'
import { CheckCircle2, Circle, ChevronDown, ChevronUp, Save, Loader2 } from 'lucide-react'

type Criterion = { id: string; code: string; name: string; sort_order: number }
type Factor = { id: string; code: string; name: string; sort_order: number; criteria: Criterion[] }
type ResponseMap = Record<string, { response_text: string; evidence_notes: string }>

interface Props {
  institutionId: string
  factors: Factor[]
  initialResponses: ResponseMap
}

export default function ComponentForm({ institutionId, factors, initialResponses }: Props) {
  const [responses, setResponses] = useState<ResponseMap>(initialResponses)
  const [savingId, setSavingId] = useState<string | null>(null)
  const [savedIds, setSavedIds] = useState<Set<string>>(new Set())
  const [openFactors, setOpenFactors] = useState<Set<string>>(() => new Set([factors[0]?.id]))
  const debounceTimers = useRef<Record<string, ReturnType<typeof setTimeout>>>({})

  const toggleFactor = (id: string) => {
    setOpenFactors(prev => {
      const next = new Set(prev)
      next.has(id) ? next.delete(id) : next.add(id)
      return next
    })
  }

  const saveResponse = useCallback(async (criteriaId: string, responseText: string, evidenceNotes: string) => {
    if (!institutionId) return
    setSavingId(criteriaId)
    try {
      await fetch('/api/portal/responses', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ institution_id: institutionId, criteria_id: criteriaId, response_text: responseText, evidence_notes: evidenceNotes }),
      })
      setSavedIds(prev => new Set(prev).add(criteriaId))
      setTimeout(() => setSavedIds(prev => { const n = new Set(prev); n.delete(criteriaId); return n }), 2000)
    } finally {
      setSavingId(null)
    }
  }, [institutionId])

  const handleChange = (criteriaId: string, field: 'response_text' | 'evidence_notes', value: string) => {
    setResponses(prev => ({
      ...prev,
      [criteriaId]: { ...prev[criteriaId], [field]: value },
    }))
    // Debounce auto-save 1.5s after typing stops
    clearTimeout(debounceTimers.current[criteriaId])
    debounceTimers.current[criteriaId] = setTimeout(() => {
      const current = responses[criteriaId] ?? { response_text: '', evidence_notes: '' }
      const updated = { ...current, [field]: value }
      saveResponse(criteriaId, updated.response_text, updated.evidence_notes)
    }, 1500)
  }

  const getFactorProgress = (factor: Factor) => {
    const total = factor.criteria.length
    const answered = factor.criteria.filter(c => responses[c.id]?.response_text?.trim()).length
    return { total, answered, pct: total > 0 ? Math.round((answered / total) * 100) : 0 }
  }

  return (
    <div className="space-y-4">
      {factors.map((factor) => {
        const { total, answered, pct } = getFactorProgress(factor)
        const isOpen = openFactors.has(factor.id)
        const isComplete = pct === 100

        return (
          <div key={factor.id} className="bg-white rounded-xl border border-gray-200 overflow-hidden">
            {/* Factor header */}
            <button
              onClick={() => toggleFactor(factor.id)}
              className="w-full text-left px-5 py-4 flex items-center justify-between hover:bg-gray-50 transition-colors"
            >
              <div className="flex items-center gap-3">
                <span className={isComplete ? 'text-green-500' : 'text-gray-300'}>
                  {isComplete ? <CheckCircle2 size={18} /> : <Circle size={18} />}
                </span>
                <div>
                  <p className="text-xs font-semibold text-gray-400 uppercase tracking-wide">{factor.code}</p>
                  <p className="text-sm font-semibold text-gray-800 mt-0.5">{factor.name}</p>
                </div>
              </div>
              <div className="flex items-center gap-4">
                <div className="text-right">
                  <p className={`text-sm font-bold ${isComplete ? 'text-green-600' : 'text-[#1B2B5E]'}`}>{pct}%</p>
                  <p className="text-xs text-gray-400">{answered}/{total}</p>
                </div>
                {isOpen ? <ChevronUp size={16} className="text-gray-400" /> : <ChevronDown size={16} className="text-gray-400" />}
              </div>
            </button>

            {/* Criteria list */}
            {isOpen && (
              <div className="border-t border-gray-100 divide-y divide-gray-50">
                {factor.criteria.map((criterion, idx) => {
                  const resp = responses[criterion.id] ?? { response_text: '', evidence_notes: '' }
                  const isAnswered = !!resp.response_text?.trim()
                  const isSaving = savingId === criterion.id
                  const wasSaved = savedIds.has(criterion.id)

                  return (
                    <div key={criterion.id} className="px-5 py-5">
                      <div className="flex items-start gap-3 mb-3">
                        <span className={`mt-0.5 flex-shrink-0 ${isAnswered ? 'text-green-500' : 'text-gray-300'}`}>
                          {isAnswered ? <CheckCircle2 size={15} /> : <Circle size={15} />}
                        </span>
                        <div className="flex-1">
                          <div className="flex items-center gap-2 mb-1">
                            <span className="text-xs font-mono text-gray-400">{criterion.code}</span>
                            <span className="text-xs text-gray-300">·</span>
                            <span className="text-xs text-gray-400">Criterion {idx + 1} of {factor.criteria.length}</span>
                          </div>
                          <p className="text-sm font-medium text-gray-800 leading-snug">{criterion.name}</p>
                        </div>
                        <div className="flex-shrink-0 flex items-center gap-1.5 text-xs">
                          {isSaving && <Loader2 size={13} className="animate-spin text-gray-400" />}
                          {wasSaved && !isSaving && (
                            <span className="text-green-600 flex items-center gap-1">
                              <Save size={12} /> Saved
                            </span>
                          )}
                        </div>
                      </div>

                      <div className="ml-6 space-y-3">
                        <div>
                          <label className="block text-xs font-semibold text-gray-500 mb-1.5">
                            Evidence and narrative response <span className="text-red-400">*</span>
                          </label>
                          <textarea
                            rows={4}
                            placeholder="Describe how your institution meets this criterion. Include specific evidence, data, processes, or policies that demonstrate compliance..."
                            value={resp.response_text}
                            onChange={e => handleChange(criterion.id, 'response_text', e.target.value)}
                            className="w-full text-sm border border-gray-200 rounded-lg px-3 py-2.5 resize-none focus:outline-none focus:ring-2 focus:ring-[#1B2B5E]/20 focus:border-[#1B2B5E] placeholder:text-gray-300 text-gray-800"
                          />
                        </div>
                        <div>
                          <label className="block text-xs font-semibold text-gray-500 mb-1.5">
                            Supporting documentation notes <span className="text-gray-400 font-normal">(optional)</span>
                          </label>
                          <textarea
                            rows={2}
                            placeholder="List any documents, files, or references you will attach as evidence (e.g., 'Institutional Strategic Plan 2023-2026', 'Accreditation Resolution No. 001')"
                            value={resp.evidence_notes}
                            onChange={e => handleChange(criterion.id, 'evidence_notes', e.target.value)}
                            className="w-full text-sm border border-gray-200 rounded-lg px-3 py-2.5 resize-none focus:outline-none focus:ring-2 focus:ring-[#1B2B5E]/20 focus:border-[#1B2B5E] placeholder:text-gray-300 text-gray-800"
                          />
                        </div>
                      </div>
                    </div>
                  )
                })}
              </div>
            )}
          </div>
        )
      })}
    </div>
  )
}
