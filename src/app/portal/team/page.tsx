import { Users } from 'lucide-react'

export default function TeamPage() {
  return (
    <div className="p-8">
      <div className="mb-8">
        <h1 className="text-2xl font-bold text-gray-900">Team</h1>
        <p className="text-gray-500 mt-1 text-sm">Invite colleagues to collaborate on your accreditation application</p>
      </div>

      <div className="bg-white rounded-xl border border-gray-200 p-16 text-center">
        <Users size={40} className="text-gray-300 mx-auto mb-4" />
        <h3 className="text-gray-600 font-medium mb-1">Team management coming soon</h3>
        <p className="text-gray-400 text-sm">You will be able to invite and manage team members here.</p>
      </div>
    </div>
  )
}
