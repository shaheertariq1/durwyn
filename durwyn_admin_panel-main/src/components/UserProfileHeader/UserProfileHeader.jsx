import Icon from '../Icon/Icon.jsx'
import Avatar from '../Avatar/Avatar.jsx'
import Badge from '../Badge/Badge.jsx'
import { planLabels, statusLabels } from '../../data/mockUsers.js'
import './UserProfileHeader.css'

const PLAN_TONE = { free: 'neutral', standard: 'blue', premium: 'purple' }
const STATUS_TONE = { active: 'green', suspended: 'red' }

// Avatar + name + badges + contact line + quick meta, shown atop the user detail screen.
function UserProfileHeader({ user, onEdit, onDelete }) {
  return (
    <div className="user-profile-header">
      <Avatar name={user.name} size={56} className="user-profile-header__avatar" />

      <div className="user-profile-header__info">
        <div className="user-profile-header__name-row">
          <h2 className="user-profile-header__name">{user.name}</h2>
          <Badge tone={PLAN_TONE[user.plan]}>{planLabels[user.plan]}</Badge>
          <Badge tone={STATUS_TONE[user.status]}>{statusLabels[user.status]}</Badge>
        </div>
        <p className="user-profile-header__contact">
          {user.email} · {user.phone} · {user.location}
        </p>
        <div className="user-profile-header__meta">
          <span>
            ID: <span className="user-profile-header__mono">{user.id}</span>
          </span>
          <span>Joined: {user.joined}</span>
          <span>
            Emergencies: <span className="user-profile-header__emergencies">{user.stats.emergencies}</span>
          </span>
        </div>
      </div>

      <div className="user-profile-header__actions">
        <button type="button" className="user-profile-header__action" onClick={onEdit}>
          <Icon name="action-edit-icon" size={12} />
          Edit
        </button>
        <button
          type="button"
          className="user-profile-header__action user-profile-header__action--danger"
          onClick={onDelete}
        >
          <Icon name="action-delete-icon" size={12} />
          Delete
        </button>
      </div>
    </div>
  )
}

export default UserProfileHeader
