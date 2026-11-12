import { useEffect, useRef, useState } from 'react'
import { useLocation, useNavigate } from 'react-router-dom'
import Icon from '../Icon/Icon.jsx'
import NotificationsDropdown from '../NotificationsDropdown/NotificationsDropdown.jsx'
import { NAV_ITEMS } from '../../data/navigation.js'
import { currentUser, notificationFeed } from '../../data/mockDashboard.js'
import avatarElena from '../../assets/avatar-elena.png'
import './TopNav.css'

function useSectionTitle() {
  const { pathname } = useLocation()
  const match = NAV_ITEMS.find((item) =>
    item.path === '/dashboard' ? pathname === item.path : pathname.startsWith(item.path),
  )
  return match?.label ?? 'Dashboard'
}

function TopNav({ onOpenSidebar }) {
  const title = useSectionTitle()
  const navigate = useNavigate()
  const [searchTerm, setSearchTerm] = useState('')
  const [notificationsOpen, setNotificationsOpen] = useState(false)
  const notificationsRef = useRef(null)

  useEffect(() => {
    if (!notificationsOpen) return undefined

    function handlePointerDown(event) {
      if (notificationsRef.current && !notificationsRef.current.contains(event.target)) {
        setNotificationsOpen(false)
      }
    }
    function handleKeyDown(event) {
      if (event.key === 'Escape') setNotificationsOpen(false)
    }

    document.addEventListener('mousedown', handlePointerDown)
    document.addEventListener('keydown', handleKeyDown)
    return () => {
      document.removeEventListener('mousedown', handlePointerDown)
      document.removeEventListener('keydown', handleKeyDown)
    }
  }, [notificationsOpen])

  return (
    <header className="top-nav">
      <div className="top-nav__lead">
        <button
          type="button"
          className="top-nav__menu-button"
          onClick={onOpenSidebar}
          aria-label="Open navigation"
        >
          <svg width="20" height="20" viewBox="0 0 20 20" fill="none" aria-hidden="true">
            <path
              d="M2.5 5h15M2.5 10h15M2.5 15h15"
              stroke="currentColor"
              strokeWidth="1.66667"
              strokeLinecap="round"
            />
          </svg>
        </button>
        <h1 className="top-nav__title">{title}</h1>
      </div>

      <div className="top-nav__actions">
        <label className="top-nav__search">
          <Icon name="topnav-search-icon" size={20} />
          <input
            type="search"
            placeholder="Search...."
            value={searchTerm}
            onChange={(event) => setSearchTerm(event.target.value)}
            aria-label="Search"
          />
        </label>

        <div className="top-nav__notifications" ref={notificationsRef}>
          <button
            type="button"
            className="top-nav__bell"
            aria-label="Notifications"
            aria-haspopup="dialog"
            aria-expanded={notificationsOpen}
            onClick={() => setNotificationsOpen((current) => !current)}
          >
            <Icon name="topnav-bell-icon" size={17} />
            {currentUser.unreadNotifications > 0 && (
              <span className="top-nav__bell-badge">{currentUser.unreadNotifications}</span>
            )}
          </button>
          {notificationsOpen && (
            <div className="top-nav__notifications-panel">
              <NotificationsDropdown
                items={notificationFeed}
                newCount={currentUser.unreadNotifications}
                onViewAll={() => {
                  setNotificationsOpen(false)
                  navigate('/dashboard/notifications')
                }}
              />
            </div>
          )}
        </div>

        <div className="top-nav__profile">
          <img className="top-nav__avatar" src={avatarElena} alt="" />
          <div className="top-nav__profile-text">
            <p className="top-nav__profile-name">{currentUser.name}</p>
            <p className="top-nav__profile-role">{currentUser.role}</p>
          </div>
        </div>
      </div>
    </header>
  )
}

export default TopNav
