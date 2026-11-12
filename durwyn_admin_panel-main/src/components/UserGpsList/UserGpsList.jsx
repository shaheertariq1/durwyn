import Avatar from '../Avatar/Avatar.jsx'
import { planLabels } from '../../data/mockUsers.js'
import './UserGpsList.css'

// "Select User" panel on the GPS History screen — picks which user's route
// the map panel on the right renders.
function UserGpsList({ users, selectedUserId, onSelect }) {
  return (
    <div className="user-gps-list">
      <p className="user-gps-list__heading">Select User</p>
      <div className="user-gps-list__items" role="listbox" aria-label="Select user">
        {users.map((user) => {
          const isSelected = user.id === selectedUserId
          return (
            <button
              key={user.id}
              type="button"
              role="option"
              aria-selected={isSelected}
              className={`user-gps-list__item ${isSelected ? 'user-gps-list__item--selected' : ''}`.trim()}
              onClick={() => onSelect(user.id)}
            >
              <Avatar name={user.name} size={24.5} />
              <span className="user-gps-list__item-text">
                <span className="user-gps-list__item-name">{user.name}</span>
                <span className="user-gps-list__item-plan">{planLabels[user.plan]}</span>
              </span>
            </button>
          )
        })}
      </div>
    </div>
  )
}

export default UserGpsList
