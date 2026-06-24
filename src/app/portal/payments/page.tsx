import { CreditCard } from 'lucide-react'

export default function PortalPaymentsPage() {
  return (
    <div className="p-8">
      <div className="mb-8">
        <h1 className="text-2xl font-bold text-gray-900">Payments</h1>
        <p className="text-gray-500 mt-1 text-sm">Manage your accreditation fees and payment history</p>
      </div>

      <div className="bg-white rounded-xl border border-gray-200 p-16 text-center">
        <CreditCard size={40} className="text-gray-300 mx-auto mb-4" />
        <h3 className="text-gray-600 font-medium mb-1">No payments due yet</h3>
        <p className="text-gray-400 text-sm">Payment will be required once you complete and submit your application.</p>
      </div>
    </div>
  )
}
