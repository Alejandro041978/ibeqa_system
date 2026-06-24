import { FileText } from 'lucide-react'

export default function ApplicationPage() {
  return (
    <div className="p-8">
      <div className="mb-8">
        <h1 className="text-2xl font-bold text-gray-900">My Application</h1>
        <p className="text-gray-500 mt-1 text-sm">Complete all 72 MIAC-U evaluation criteria to submit your accreditation application</p>
      </div>

      <div className="bg-white rounded-xl border border-gray-200 p-16 text-center">
        <FileText size={40} className="text-gray-300 mx-auto mb-4" />
        <h3 className="text-gray-600 font-medium mb-1">Application forms coming soon</h3>
        <p className="text-gray-400 text-sm">The 72 evaluation criteria forms are being prepared.</p>
      </div>
    </div>
  )
}
