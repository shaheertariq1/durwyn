import { NavLink, useNavigate } from 'react-router-dom'
import Icon from '../Icon/Icon.jsx'
import logoFull from '../../assets/logo-full.png'
import { NAV_ITEMS } from '../../data/navigation.js'
import './Sidebar.css'

function Sidebar({ isOpen, onClose }) {
  const navigate = useNavigate()

  return (
    <aside
      className={`sidebar ${isOpen ? 'sidebar--open' : ''}`.trim()}
      aria-label="Primary navigation"
    >
      <div className="sidebar__brand">
        <div className="sidebar__brand-badge">
          <img src={logoFull} alt="Trouble Cheat" className="sidebar__brand-mark" />
        </div>
        <div className="sidebar__brand-text">
          <p className="sidebar__brand-subtitle">Admin Portal</p>
        </div>
      </div>

      <nav className="sidebar__nav" aria-label="Sections">
        {NAV_ITEMS.map((item) => (
          <NavLink
            key={item.path}
            to={item.path}
            end={item.path === '/dashboard'}
            onClick={onClose}
            className={({ isActive }) =>
              `sidebar__link ${isActive ? 'sidebar__link--active' : ''}`.trim()
            }
          >
            <Icon name={item.icon} size={20} className="sidebar__link-icon" />
            <span className="sidebar__link-label">{item.label}</span>
          </NavLink>
        ))}
      </nav>

      <div className="sidebar__footer">
        <button
          type="button"
          className="sidebar__logout"
          onClick={() => navigate('/login', { replace: true })}
        >
          <Icon name="nav-logout-icon" size={14} />
          <span>Logout</span>
        </button>
      </div>
    </aside>
  )
}

export default Sidebar
