import Icon from '../Icon/Icon.jsx'
import './RecentActivity.css'

function RecentActivity({ items, onViewAll }) {
  return (
    <section className="recent-activity">
      <div className="recent-activity__head">
        <p className="recent-activity__title">Recent Activity</p>
        <button type="button" className="recent-activity__view-all" onClick={onViewAll}>
          View all
        </button>
      </div>

      <ul className="recent-activity__list">
        {items.map((item) => (
          <li key={item.id} className="recent-activity__item">
            <span className={`recent-activity__icon recent-activity__icon--${item.tint}`}>
              <Icon name={item.icon} size={13} />
            </span>
            <div className="recent-activity__text">
              <p className="recent-activity__item-title">{item.title}</p>
              <p className="recent-activity__item-detail">{item.detail}</p>
            </div>
            <span className="recent-activity__time">{item.time}</span>
          </li>
        ))}
      </ul>
    </section>
  )
}

export default RecentActivity
