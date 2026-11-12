import Icon from '../Icon/Icon.jsx'
import './QuickActions.css'

function QuickActions({ actions, onSelect }) {
  return (
    <section className="quick-actions">
      <p className="quick-actions__title">Quick Actions</p>
      <ul className="quick-actions__list">
        {actions.map((action) => (
          <li key={action.id}>
            <button
              type="button"
              className="quick-actions__button"
              onClick={() => onSelect?.(action.id)}
            >
              <span className={`quick-actions__icon quick-actions__icon--${action.tint}`}>
                <Icon name={action.icon} size={13} />
              </span>
              <span className="quick-actions__label">{action.label}</span>
            </button>
          </li>
        ))}
      </ul>
    </section>
  )
}

export default QuickActions
