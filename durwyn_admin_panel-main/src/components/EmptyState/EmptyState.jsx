import Icon from '../Icon/Icon.jsx'
import './EmptyState.css'

function EmptyState({ icon, title, message }) {
  return (
    <div className="empty-state" role="status">
      {icon && (
        <span className="empty-state__icon">
          <Icon name={icon} size={28} />
        </span>
      )}
      <p className="empty-state__title">{title}</p>
      {message && <p className="empty-state__message">{message}</p>}
    </div>
  )
}

export default EmptyState
