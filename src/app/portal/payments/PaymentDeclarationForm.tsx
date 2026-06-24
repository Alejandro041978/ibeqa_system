'use client'

import { useState } from 'react'
import { Upload, Loader2, CheckCircle2, AlertCircle, X, FileText } from 'lucide-react'

type FeeItem = { key: string; name: string; usd: number }

interface Props {
  institutionId: string
  feeItems: FeeItem[]
}

export default function PaymentDeclarationForm({ institutionId, feeItems }: Props) {
  const [feeType, setFeeType] = useState('')
  const [currency, setCurrency] = useState<'GBP' | 'EUR'>('GBP')
  const [amount, setAmount] = useState('')
  const [transferDate, setTransferDate] = useState('')
  const [bankReference, setBankReference] = useState('')
  const [payerName, setPayerName] = useState('')
  const [notes, setNotes] = useState('')
  const [file, setFile] = useState<File | null>(null)
  const [status, setStatus] = useState<'idle' | 'loading' | 'success' | 'error'>('idle')
  const [message, setMessage] = useState('')

  function handleFileChange(e: React.ChangeEvent<HTMLInputElement>) {
    const f = e.target.files?.[0]
    if (!f) return
    if (f.size > 10 * 1024 * 1024) {
      setStatus('error')
      setMessage('File must be smaller than 10 MB.')
      return
    }
    setFile(f)
    setStatus('idle')
    setMessage('')
  }

  async function handleSubmit(e: React.FormEvent) {
    e.preventDefault()
    if (!feeType || !amount || !transferDate || !file) return

    setStatus('loading')
    setMessage('')

    try {
      const formData = new FormData()
      formData.append('institution_id', institutionId)
      formData.append('fee_type', feeType)
      formData.append('currency', currency)
      formData.append('amount_declared', amount)
      formData.append('transfer_date', transferDate)
      formData.append('bank_reference', bankReference)
      formData.append('payer_name', payerName)
      formData.append('notes', notes)
      formData.append('evidence', file)

      const res = await fetch('/api/portal/payments', { method: 'POST', body: formData })
      const data = await res.json()

      if (!res.ok) {
        setStatus('error')
        setMessage(data.error ?? 'Something went wrong. Please try again.')
      } else {
        setStatus('success')
        setMessage('Payment declared successfully. Our team will verify your transfer within 2 business days.')
        setFeeType(''); setCurrency('GBP'); setAmount(''); setTransferDate('')
        setBankReference(''); setPayerName(''); setNotes(''); setFile(null)
      }
    } catch {
      setStatus('error')
      setMessage('Network error. Please try again.')
    }
  }

  const selectedFee = feeItems.find(f => f.key === feeType)

  return (
    <form onSubmit={handleSubmit} className="space-y-5">
      {/* Fee type */}
      <div>
        <label className="block text-xs font-semibold text-gray-500 mb-1.5">
          Fee type <span className="text-red-400">*</span>
        </label>
        <select
          required
          value={feeType}
          onChange={e => setFeeType(e.target.value)}
          className="w-full text-sm border border-gray-200 rounded-lg px-3 py-2.5 focus:outline-none focus:ring-2 focus:ring-[#1B2B5E]/20 focus:border-[#1B2B5E] bg-white text-gray-800"
        >
          <option value="">Select a fee...</option>
          {feeItems.map(f => (
            <option key={f.key} value={f.key}>
              {f.name} — ${f.usd.toLocaleString()} USD
            </option>
          ))}
        </select>
        {selectedFee && (
          <p className="text-xs text-gray-400 mt-1.5">
            Reference amount: <span className="font-semibold text-gray-600">${selectedFee.usd.toLocaleString()} USD</span>.
            Enter the GBP or EUR equivalent you transferred.
          </p>
        )}
      </div>

      {/* Currency + amount */}
      <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
        <div>
          <label className="block text-xs font-semibold text-gray-500 mb-1.5">
            Payment currency <span className="text-red-400">*</span>
          </label>
          <div className="grid grid-cols-2 gap-2">
            {(['GBP', 'EUR'] as const).map(cur => (
              <button
                key={cur}
                type="button"
                onClick={() => setCurrency(cur)}
                className={`py-2.5 rounded-lg text-sm font-medium border transition-colors ${
                  currency === cur
                    ? 'bg-[#1B2B5E] text-white border-[#1B2B5E]'
                    : 'bg-white text-gray-600 border-gray-200 hover:border-gray-300'
                }`}
              >
                {cur === 'GBP' ? '🇬🇧 GBP' : '🇪🇺 EUR'}
              </button>
            ))}
          </div>
        </div>
        <div>
          <label className="block text-xs font-semibold text-gray-500 mb-1.5">
            Amount transferred <span className="text-red-400">*</span>
          </label>
          <div className="relative">
            <span className="absolute left-3 top-1/2 -translate-y-1/2 text-sm text-gray-400 font-medium">
              {currency === 'GBP' ? '£' : '€'}
            </span>
            <input
              type="number"
              required
              min="0"
              step="0.01"
              placeholder="0.00"
              value={amount}
              onChange={e => setAmount(e.target.value)}
              className="w-full text-sm border border-gray-200 rounded-lg pl-7 pr-3 py-2.5 focus:outline-none focus:ring-2 focus:ring-[#1B2B5E]/20 focus:border-[#1B2B5E] placeholder:text-gray-300"
            />
          </div>
        </div>
      </div>

      {/* Date + reference */}
      <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
        <div>
          <label className="block text-xs font-semibold text-gray-500 mb-1.5">
            Date of transfer <span className="text-red-400">*</span>
          </label>
          <input
            type="date"
            required
            value={transferDate}
            max={new Date().toISOString().split('T')[0]}
            onChange={e => setTransferDate(e.target.value)}
            className="w-full text-sm border border-gray-200 rounded-lg px-3 py-2.5 focus:outline-none focus:ring-2 focus:ring-[#1B2B5E]/20 focus:border-[#1B2B5E] text-gray-800"
          />
        </div>
        <div>
          <label className="block text-xs font-semibold text-gray-500 mb-1.5">Bank reference / transaction ID</label>
          <input
            type="text"
            placeholder="e.g. TXN-2024-001234"
            value={bankReference}
            onChange={e => setBankReference(e.target.value)}
            className="w-full text-sm border border-gray-200 rounded-lg px-3 py-2.5 focus:outline-none focus:ring-2 focus:ring-[#1B2B5E]/20 focus:border-[#1B2B5E] placeholder:text-gray-300"
          />
        </div>
      </div>

      {/* Sender name */}
      <div>
        <label className="block text-xs font-semibold text-gray-500 mb-1.5">Sender name (as shown on bank transfer)</label>
        <input
          type="text"
          placeholder="e.g. Universidad Nacional de Ejemplo"
          value={payerName}
          onChange={e => setPayerName(e.target.value)}
          className="w-full text-sm border border-gray-200 rounded-lg px-3 py-2.5 focus:outline-none focus:ring-2 focus:ring-[#1B2B5E]/20 focus:border-[#1B2B5E] placeholder:text-gray-300"
        />
      </div>

      {/* Evidence upload */}
      <div>
        <label className="block text-xs font-semibold text-gray-500 mb-1.5">
          Bank receipt / transfer confirmation <span className="text-red-400">*</span>
        </label>
        {file ? (
          <div className="flex items-center gap-3 bg-blue-50 border border-blue-200 rounded-lg px-4 py-3">
            <FileText size={18} className="text-blue-500 flex-shrink-0" />
            <div className="flex-1 min-w-0">
              <p className="text-sm font-medium text-gray-800 truncate">{file.name}</p>
              <p className="text-xs text-gray-400">{(file.size / 1024).toFixed(0)} KB</p>
            </div>
            <button type="button" onClick={() => setFile(null)} className="text-gray-400 hover:text-gray-600">
              <X size={16} />
            </button>
          </div>
        ) : (
          <label className="flex flex-col items-center justify-center w-full h-28 border-2 border-dashed border-gray-200 rounded-lg cursor-pointer hover:border-[#1B2B5E]/40 hover:bg-gray-50 transition-colors">
            <Upload size={20} className="text-gray-300 mb-2" />
            <span className="text-sm text-gray-400">Click to upload receipt</span>
            <span className="text-xs text-gray-300 mt-1">PDF, JPG, PNG — max 10 MB</span>
            <input type="file" className="hidden" accept=".pdf,.jpg,.jpeg,.png" onChange={handleFileChange} required />
          </label>
        )}
      </div>

      {/* Notes */}
      <div>
        <label className="block text-xs font-semibold text-gray-500 mb-1.5">
          Additional notes <span className="text-gray-400 font-normal">(optional)</span>
        </label>
        <textarea
          rows={2}
          placeholder="Any additional information for the IBEQA finance team..."
          value={notes}
          onChange={e => setNotes(e.target.value)}
          className="w-full text-sm border border-gray-200 rounded-lg px-3 py-2.5 resize-none focus:outline-none focus:ring-2 focus:ring-[#1B2B5E]/20 focus:border-[#1B2B5E] placeholder:text-gray-300"
        />
      </div>

      {/* Submit */}
      <div className="flex items-start gap-3 pt-1">
        <button
          type="submit"
          disabled={status === 'loading' || !feeType || !amount || !transferDate || !file}
          className="inline-flex items-center gap-2 bg-[#1B2B5E] text-white text-sm font-medium px-5 py-2.5 rounded-lg hover:bg-[#162347] transition-colors disabled:opacity-50 disabled:cursor-not-allowed"
        >
          {status === 'loading'
            ? <><Loader2 size={15} className="animate-spin" /> Submitting...</>
            : 'Submit payment declaration'}
        </button>

        {status === 'success' && (
          <div className="flex items-start gap-1.5 text-sm text-green-600">
            <CheckCircle2 size={16} className="flex-shrink-0 mt-0.5" />
            <span>{message}</span>
          </div>
        )}
        {status === 'error' && (
          <div className="flex items-start gap-1.5 text-sm text-red-500">
            <AlertCircle size={16} className="flex-shrink-0 mt-0.5" />
            <span>{message}</span>
          </div>
        )}
      </div>
    </form>
  )
}
