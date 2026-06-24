import { createClient } from '@/lib/supabase/server'
import { createClient as createAdminClient } from '@supabase/supabase-js'
import { CheckCircle2, Clock, XCircle, Info, AlertTriangle } from 'lucide-react'
import PaymentDeclarationForm from './PaymentDeclarationForm'

const supabaseAdmin = createAdminClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL!,
  process.env.SUPABASE_SERVICE_ROLE_KEY!,
  { auth: { autoRefreshToken: false, persistSession: false } }
)

type InstitutionSize = 'small' | 'medium' | 'large'

const SIZE_LABELS: Record<InstitutionSize, string> = {
  small: 'Small (2,000–19,999 students)',
  medium: 'Medium (20,000–99,999 students)',
  large: 'Large (100,000+ students)',
}

const FEE_SCHEDULE: Record<InstitutionSize, {
  accreditation: number
  site_visit_per_day: number
  site_visit_days: number
  annual_fee: number
}> = {
  small:  { accreditation: 5000,  site_visit_per_day: 3000, site_visit_days: 1, annual_fee: 1000 },
  medium: { accreditation: 10000, site_visit_per_day: 3000, site_visit_days: 2, annual_fee: 2000 },
  large:  { accreditation: 20000, site_visit_per_day: 3000, site_visit_days: 3, annual_fee: 4000 },
}

const BANK_ACCOUNTS = {
  GBP: {
    flag: '🇬🇧',
    label: 'Pounds Sterling (GBP)',
    accountName: 'Ibeqa Ltd',
    bank: 'Wise Payments Limited, Worship Square, 65 Clifton Street, London, EC2A 4JE, United Kingdom',
    sortCode: '60-84-64',
    accountNumber: '15920604',
    iban: 'GB20 TRWI 6084 6415 9206 04',
    swift: 'TRWIGB2LXXX',
  },
  EUR: {
    flag: '🇪🇺',
    label: 'Euros (EUR)',
    accountName: 'Ibeqa Ltd',
    bank: 'Wise, Rue du Trône 100, 3rd floor, Brussels, 1050, Belgium',
    iban: 'BE51 9056 5320 3562',
    swift: 'TRWIBEB1XXX',
  },
}

const STATUS_CONFIG = {
  pending:  { label: 'Pending verification', Icon: Clock,         color: 'text-amber-600', bg: 'bg-amber-50 border-amber-200' },
  verified: { label: 'Payment confirmed',    Icon: CheckCircle2,  color: 'text-green-600', bg: 'bg-green-50 border-green-200' },
  rejected: { label: 'Payment rejected',     Icon: XCircle,       color: 'text-red-600',   bg: 'bg-red-50 border-red-200' },
}

const FEE_LABELS: Record<string, string> = {
  accreditation: 'Institutional Accreditation (3 years)',
  site_visit:    'Peer Evaluator Site Visit',
  annual_fee:    'Annual Membership Fee',
}

export default async function PaymentsPage() {
  const supabase = await createClient()
  const { data: { user } } = await supabase.auth.getUser()
  const institutionId = user?.user_metadata?.institution_id

  // Get institution size
  const { data: institution } = institutionId
    ? await supabaseAdmin.from('institutions').select('size, student_count').eq('id', institutionId).single()
    : { data: null }

  const size: InstitutionSize = (institution?.size ?? 'small') as InstitutionSize
  const fees = FEE_SCHEDULE[size]
  const siteVisitTotal = fees.site_visit_per_day * fees.site_visit_days

  const feeItems = [
    {
      key: 'accreditation',
      name: 'Institutional Accreditation',
      duration: '3-year accreditation cycle',
      description: 'Full documentary and criteria evaluation by the IBEQA panel, culminating in the accreditation decision.',
      usd: fees.accreditation,
    },
    {
      key: 'site_visit',
      name: 'Peer Evaluator Site Visit',
      duration: `${fees.site_visit_days} day${fees.site_visit_days > 1 ? 's' : ''} × $${fees.site_visit_per_day.toLocaleString()}/day`,
      description: `On-site evaluation by a team of IBEQA peer evaluators. ${fees.site_visit_days} visit day${fees.site_visit_days > 1 ? 's' : ''} scheduled based on your institution size.`,
      usd: siteVisitTotal,
    },
    {
      key: 'annual_fee',
      name: 'Annual Membership Fee',
      duration: 'Billed annually after accreditation',
      description: 'Annual fee to maintain IBEQA accreditation status, access to quality reports, and listing in the IBEQA accredited institutions registry.',
      usd: fees.annual_fee,
    },
  ]

  const { data: payments } = institutionId
    ? await supabaseAdmin
        .from('payments')
        .select('*')
        .eq('institution_id', institutionId)
        .order('created_at', { ascending: false })
    : { data: [] }

  const paidFeeTypes = new Set((payments ?? []).filter(p => p.status === 'verified').map(p => p.fee_type))
  const totalPaid = (payments ?? [])
    .filter(p => p.status === 'verified')
    .reduce((sum: number, p) => sum + Number(p.amount_declared), 0)

  return (
    <div className="p-8 max-w-4xl">
      <div className="mb-8">
        <h1 className="text-2xl font-bold text-gray-900">Payments</h1>
        <p className="text-gray-500 mt-1 text-sm">
          All fees are payable by bank transfer in GBP or EUR. Declare your payment below after making the transfer.
        </p>
      </div>

      {/* Institution size banner */}
      <div className="bg-[#1B2B5E]/5 border border-[#1B2B5E]/15 rounded-xl px-5 py-4 mb-6 flex items-start gap-3">
        <Info size={16} className="text-[#1B2B5E] flex-shrink-0 mt-0.5" />
        <div>
          <p className="text-sm font-semibold text-[#1B2B5E]">
            Fee tier: {SIZE_LABELS[size]}
          </p>
          <p className="text-xs text-[#1B2B5E]/70 mt-0.5">
            Your fees are calculated based on your institution's enrolment. Fees are quoted in USD and payable in GBP or EUR equivalent on the date of transfer.
          </p>
        </div>
      </div>

      {/* Fee Schedule */}
      <div className="bg-white rounded-xl border border-gray-200 overflow-hidden mb-6">
        <div className="px-6 py-4 border-b border-gray-100">
          <h2 className="text-sm font-semibold text-gray-800">Fee Schedule</h2>
        </div>
        <div className="divide-y divide-gray-50">
          {feeItems.map((fee) => {
            const isPaid = paidFeeTypes.has(fee.key)
            return (
              <div key={fee.key} className={`px-6 py-5 flex items-start justify-between gap-4 ${isPaid ? 'bg-green-50/50' : ''}`}>
                <div className="flex items-start gap-3">
                  <div className={`flex-shrink-0 mt-0.5 ${isPaid ? 'text-green-500' : 'text-gray-300'}`}>
                    {isPaid
                      ? <CheckCircle2 size={18} />
                      : <div className="w-[18px] h-[18px] rounded-full border-2 border-gray-300" />}
                  </div>
                  <div>
                    <div className="flex items-center gap-2 mb-0.5">
                      <p className="text-sm font-semibold text-gray-900">{fee.name}</p>
                      {isPaid && <span className="text-xs text-green-600 font-semibold bg-green-100 px-2 py-0.5 rounded-full">Paid</span>}
                    </div>
                    <p className="text-xs text-gray-400 mb-1">{fee.duration}</p>
                    <p className="text-xs text-gray-500 max-w-lg leading-relaxed">{fee.description}</p>
                  </div>
                </div>
                <div className="text-right flex-shrink-0">
                  <p className="text-lg font-bold text-gray-900">${fee.usd.toLocaleString()}</p>
                  <p className="text-xs text-gray-400">USD</p>
                </div>
              </div>
            )
          })}
        </div>
        <div className="px-6 py-3 bg-gray-50 border-t border-gray-100">
          <div className="flex items-center justify-between">
            <div className="flex items-center gap-2">
              <AlertTriangle size={13} className="text-amber-500" />
              <p className="text-xs text-gray-500">
                Fees are quoted in USD and payable in GBP or EUR equivalent. VAT may apply.
              </p>
            </div>
            <p className="text-xs font-semibold text-gray-700">
              Total: ${(fees.accreditation + siteVisitTotal + fees.annual_fee).toLocaleString()} USD
            </p>
          </div>
        </div>
      </div>

      {/* Bank Account Details */}
      <div className="grid grid-cols-1 sm:grid-cols-2 gap-4 mb-6">
        {Object.values(BANK_ACCOUNTS).map((account) => (
          <div key={account.label} className="bg-white rounded-xl border border-gray-200 p-5">
            <p className="text-xs font-semibold text-gray-500 uppercase tracking-wide mb-4">
              {account.flag} {account.label}
            </p>
            <div className="space-y-2.5">
              {[
                ['Account name', account.accountName],
                ['Bank', account.bank],
                ...('sortCode' in account ? [['Sort code', account.sortCode], ['Account no.', account.accountNumber]] : []),
                ['IBAN', account.iban],
                ['SWIFT / BIC', account.swift],
              ].map(([label, value]) => (
                <div key={label} className="flex items-center justify-between gap-4">
                  <span className="text-xs text-gray-400 flex-shrink-0">{label}</span>
                  <span className="text-xs font-mono font-medium text-gray-800 text-right">{value}</span>
                </div>
              ))}
            </div>
          </div>
        ))}
      </div>

      {/* Payment history */}
      {(payments ?? []).length > 0 && (
        <div className="bg-white rounded-xl border border-gray-200 overflow-hidden mb-6">
          <div className="px-6 py-4 border-b border-gray-100 flex items-center justify-between">
            <h2 className="text-sm font-semibold text-gray-800">Payment History</h2>
            {totalPaid > 0 && (
              <span className="text-xs text-gray-400">
                Total confirmed: <span className="font-semibold text-gray-700">{totalPaid.toLocaleString('en-GB', { minimumFractionDigits: 2 })} (mixed currencies)</span>
              </span>
            )}
          </div>
          <div className="divide-y divide-gray-50">
            {(payments ?? []).map((payment: {
              id: string; fee_type: string; currency: string; amount_declared: number
              transfer_date: string; status: string; rejection_reason?: string
              bank_reference?: string; payer_name?: string; evidence_url?: string
            }) => {
              const cfg = STATUS_CONFIG[payment.status as keyof typeof STATUS_CONFIG]
              const { Icon } = cfg
              return (
                <div key={payment.id} className="px-6 py-4">
                  <div className="flex items-start justify-between gap-4">
                    <div>
                      <p className="text-sm font-medium text-gray-800">
                        {FEE_LABELS[payment.fee_type] ?? payment.fee_type}
                      </p>
                      <p className="text-xs text-gray-400 mt-0.5">
                        {payment.currency === 'GBP' ? '£' : '€'}{Number(payment.amount_declared).toLocaleString('en-GB', { minimumFractionDigits: 2 })} {payment.currency}
                        {' · '}Transfer date: {new Date(payment.transfer_date).toLocaleDateString('en-GB', { day: 'numeric', month: 'short', year: 'numeric' })}
                        {payment.bank_reference && ` · Ref: ${payment.bank_reference}`}
                      </p>
                      {payment.evidence_url && (
                        <a href={payment.evidence_url} target="_blank" rel="noopener noreferrer"
                          className="text-xs text-[#1B2B5E] underline mt-1 inline-block">
                          View receipt →
                        </a>
                      )}
                    </div>
                    <span className={`inline-flex items-center gap-1.5 text-xs font-medium px-2.5 py-1 rounded-full border flex-shrink-0 ${cfg.bg} ${cfg.color}`}>
                      <Icon size={12} />
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

      {/* Declare payment */}
      <div className="bg-white rounded-xl border border-gray-200 p-6">
        <h2 className="text-sm font-semibold text-gray-800 mb-1">Declare a bank transfer</h2>
        <p className="text-xs text-gray-400 mb-5">
          After completing your transfer, fill in the details below and attach your bank receipt. Our team will verify and confirm your payment within 2 business days.
        </p>
        <PaymentDeclarationForm
          institutionId={institutionId ?? ''}
          feeItems={feeItems.map(f => ({ key: f.key, name: f.name, usd: f.usd }))}
        />
      </div>
    </div>
  )
}
