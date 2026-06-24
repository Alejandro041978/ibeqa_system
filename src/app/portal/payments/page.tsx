import { createClient } from '@/lib/supabase/server'
import { createClient as createAdminClient } from '@supabase/supabase-js'
import { CheckCircle2, Clock, XCircle, Info } from 'lucide-react'
import PaymentDeclarationForm from './PaymentDeclarationForm'

const supabaseAdmin = createAdminClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL!,
  process.env.SUPABASE_SERVICE_ROLE_KEY!,
  { auth: { autoRefreshToken: false, persistSession: false } }
)

const FEE_SCHEDULE = [
  {
    key: 'application',
    stage: 'Stage 1',
    name: 'Application Processing Fee',
    description: 'Covers the administrative review and eligibility confirmation of your accreditation application.',
    gbp: 750,
    eur: 900,
  },
  {
    key: 'evaluation',
    stage: 'Stage 2',
    name: 'Accreditation Evaluation Fee',
    description: 'Covers the full documentary and criteria evaluation by the IBEQA panel.',
    gbp: 3500,
    eur: 4200,
  },
  {
    key: 'site_visit',
    stage: 'Stage 3',
    name: 'Site Visit Fee',
    description: 'Covers the on-site evaluation visit by a team of IBEQA evaluators.',
    gbp: 2500,
    eur: 3000,
  },
  {
    key: 'certificate',
    stage: 'Stage 4',
    name: 'Accreditation Certificate & Annual Fee',
    description: 'Covers issuance of the accreditation certificate and the first year of membership.',
    gbp: 1200,
    eur: 1450,
  },
]

const BANK_ACCOUNTS = {
  GBP: {
    currency: 'Pounds Sterling (GBP)',
    flag: '🇬🇧',
    accountName: 'IBEQA Ltd',
    bank: 'Barclays Bank PLC',
    accountNumber: '12345678',
    sortCode: '20-00-00',
    iban: 'GB00 BARC 2000 0012 3456 78',
    swift: 'BARCGB22',
  },
  EUR: {
    currency: 'Euros (EUR)',
    flag: '🇪🇺',
    accountName: 'IBEQA Ltd',
    bank: 'Barclays Bank PLC',
    accountNumber: '87654321',
    iban: 'GB00 BARC 2000 0087 6543 21',
    swift: 'BARCGB22',
  },
}

const STATUS_CONFIG = {
  pending: { label: 'Pending verification', icon: Clock, color: 'text-amber-600', bg: 'bg-amber-50 border-amber-200' },
  verified: { label: 'Payment confirmed', icon: CheckCircle2, color: 'text-green-600', bg: 'bg-green-50 border-green-200' },
  rejected: { label: 'Payment rejected', icon: XCircle, color: 'text-red-600', bg: 'bg-red-50 border-red-200' },
}

export default async function PaymentsPage() {
  const supabase = await createClient()
  const { data: { user } } = await supabase.auth.getUser()
  const institutionId = user?.user_metadata?.institution_id

  const { data: payments } = institutionId
    ? await supabaseAdmin
        .from('payments')
        .select('*')
        .eq('institution_id', institutionId)
        .order('created_at', { ascending: false })
    : { data: [] }

  const paidFeeTypes = new Set((payments ?? []).filter(p => p.status === 'verified').map(p => p.fee_type))

  return (
    <div className="p-8 max-w-4xl">
      <div className="mb-8">
        <h1 className="text-2xl font-bold text-gray-900">Payments</h1>
        <p className="text-gray-500 mt-1 text-sm">
          All fees are paid by bank transfer. Once you have made the transfer, declare it below and upload your receipt for verification.
        </p>
      </div>

      {/* Fee Schedule */}
      <div className="bg-white rounded-xl border border-gray-200 overflow-hidden mb-6">
        <div className="px-6 py-4 border-b border-gray-100 flex items-center gap-2">
          <h2 className="text-sm font-semibold text-gray-800">Accreditation Fee Schedule</h2>
        </div>
        <div className="divide-y divide-gray-50">
          {FEE_SCHEDULE.map((fee) => {
            const isPaid = paidFeeTypes.has(fee.key)
            return (
              <div key={fee.key} className={`px-6 py-4 flex items-start justify-between gap-4 ${isPaid ? 'bg-green-50/40' : ''}`}>
                <div className="flex items-start gap-3">
                  <div className={`mt-0.5 flex-shrink-0 ${isPaid ? 'text-green-500' : 'text-gray-300'}`}>
                    {isPaid ? <CheckCircle2 size={18} /> : <div className="w-4.5 h-4.5 rounded-full border-2 border-gray-300 mt-0.5" />}
                  </div>
                  <div>
                    <div className="flex items-center gap-2 mb-0.5">
                      <span className="text-xs font-semibold text-gray-400 uppercase tracking-wide">{fee.stage}</span>
                      {isPaid && <span className="text-xs text-green-600 font-semibold bg-green-100 px-2 py-0.5 rounded-full">Paid</span>}
                    </div>
                    <p className="text-sm font-semibold text-gray-800">{fee.name}</p>
                    <p className="text-xs text-gray-500 mt-0.5 max-w-lg">{fee.description}</p>
                  </div>
                </div>
                <div className="text-right flex-shrink-0">
                  <p className="text-sm font-bold text-gray-900">£{fee.gbp.toLocaleString()}</p>
                  <p className="text-xs text-gray-400">€{fee.eur.toLocaleString()}</p>
                </div>
              </div>
            )
          })}
        </div>
        <div className="px-6 py-3 bg-gray-50 border-t border-gray-100 flex items-center gap-2">
          <Info size={13} className="text-gray-400 flex-shrink-0" />
          <p className="text-xs text-gray-500">
            Fees are payable in stages as you progress through accreditation. All amounts are exclusive of VAT where applicable.
          </p>
        </div>
      </div>

      {/* Bank Account Details */}
      <div className="grid grid-cols-1 sm:grid-cols-2 gap-4 mb-6">
        {Object.values(BANK_ACCOUNTS).map((account) => (
          <div key={account.currency} className="bg-white rounded-xl border border-gray-200 p-5">
            <p className="text-xs font-semibold text-gray-400 uppercase tracking-wide mb-3">
              {account.flag} {account.currency}
            </p>
            <div className="space-y-2 text-xs">
              <div className="flex justify-between">
                <span className="text-gray-500">Account name</span>
                <span className="font-medium text-gray-800">{account.accountName}</span>
              </div>
              <div className="flex justify-between">
                <span className="text-gray-500">Bank</span>
                <span className="font-medium text-gray-800">{account.bank}</span>
              </div>
              {'sortCode' in account && (
                <div className="flex justify-between">
                  <span className="text-gray-500">Sort code</span>
                  <span className="font-mono font-medium text-gray-800">{account.sortCode}</span>
                </div>
              )}
              {'sortCode' in account && (
                <div className="flex justify-between">
                  <span className="text-gray-500">Account no.</span>
                  <span className="font-mono font-medium text-gray-800">{account.accountNumber}</span>
                </div>
              )}
              <div className="flex justify-between">
                <span className="text-gray-500">IBAN</span>
                <span className="font-mono font-medium text-gray-800">{account.iban}</span>
              </div>
              <div className="flex justify-between">
                <span className="text-gray-500">SWIFT / BIC</span>
                <span className="font-mono font-medium text-gray-800">{account.swift}</span>
              </div>
            </div>
          </div>
        ))}
      </div>

      {/* Existing payment submissions */}
      {(payments ?? []).length > 0 && (
        <div className="bg-white rounded-xl border border-gray-200 overflow-hidden mb-6">
          <div className="px-6 py-4 border-b border-gray-100">
            <h2 className="text-sm font-semibold text-gray-800">Payment History</h2>
          </div>
          <div className="divide-y divide-gray-50">
            {(payments ?? []).map((payment: {
              id: string; fee_type: string; currency: string; amount_declared: number;
              transfer_date: string; status: string; rejection_reason?: string; bank_reference?: string
            }) => {
              const fee = FEE_SCHEDULE.find(f => f.key === payment.fee_type)
              const cfg = STATUS_CONFIG[payment.status as keyof typeof STATUS_CONFIG]
              const StatusIcon = cfg.icon
              return (
                <div key={payment.id} className="px-6 py-4">
                  <div className="flex items-start justify-between">
                    <div>
                      <p className="text-sm font-medium text-gray-800">{fee?.name ?? payment.fee_type}</p>
                      <p className="text-xs text-gray-400 mt-0.5">
                        {payment.currency} {Number(payment.amount_declared).toLocaleString('en-GB', { minimumFractionDigits: 2 })} · Transfer date: {new Date(payment.transfer_date).toLocaleDateString('en-GB', { day: 'numeric', month: 'short', year: 'numeric' })}
                        {payment.bank_reference && ` · Ref: ${payment.bank_reference}`}
                      </p>
                    </div>
                    <span className={`inline-flex items-center gap-1.5 text-xs font-medium px-2.5 py-1 rounded-full border ${cfg.bg} ${cfg.color}`}>
                      <StatusIcon size={12} />
                      {cfg.label}
                    </span>
                  </div>
                  {payment.status === 'rejected' && payment.rejection_reason && (
                    <p className="mt-2 text-xs text-red-500 bg-red-50 rounded-lg px-3 py-2">
                      Reason: {payment.rejection_reason}
                    </p>
                  )}
                </div>
              )
            })}
          </div>
        </div>
      )}

      {/* Declare a payment */}
      <div className="bg-white rounded-xl border border-gray-200 p-6">
        <h2 className="text-sm font-semibold text-gray-800 mb-1">Declare a bank transfer</h2>
        <p className="text-xs text-gray-400 mb-5">
          After making your transfer, fill in the details below and upload your bank receipt. Our team will verify your payment within 2 business days.
        </p>
        <PaymentDeclarationForm
          institutionId={institutionId ?? ''}
          feeSchedule={FEE_SCHEDULE.map(f => ({ key: f.key, name: f.name, gbp: f.gbp, eur: f.eur }))}
        />
      </div>
    </div>
  )
}
