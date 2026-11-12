import { useState } from 'react'
import { Outlet } from 'react-router-dom'
import Sidebar from '../../components/Sidebar/Sidebar.jsx'
import TopNav from '../../components/TopNav/TopNav.jsx'
import './AdminLayout.css'

function AdminLayout() {
  const [sidebarOpen, setSidebarOpen] = useState(false)

  return (
    <div className="admin-layout">
      <Sidebar isOpen={sidebarOpen} onClose={() => setSidebarOpen(false)} />

      {sidebarOpen && (
        <button
          type="button"
          className="admin-layout__scrim"
          aria-label="Close navigation"
          onClick={() => setSidebarOpen(false)}
        />
      )}

      <div className="admin-layout__main">
        <TopNav onOpenSidebar={() => setSidebarOpen(true)} />
        <main className="admin-layout__content">
          <Outlet />
        </main>
      </div>
    </div>
  )
}

export default AdminLayout
