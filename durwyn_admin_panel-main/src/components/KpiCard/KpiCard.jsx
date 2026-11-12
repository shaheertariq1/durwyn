import Icon from '../Icon/Icon.jsx'
import './KpiCard.css'

function KpiCard({ label, value, icon, tint, trend, meta, valueTone }) {
  return (
    <article className="kpi-card">
      <div className="kpi-card__head">
        <p className="kpi-card__label">{label}</p>
        <span className={`kpi-card__icon kpi-card__icon--${tint}`}>
          <Icon name={icon} size={15} />
        </span>
      </div>
      <div className="kpi-card__body">
        <p className={`kpi-card__value${valueTone ? ` kpi-card__value--${valueTone}` : ''}`}>{value}</p>
        {trend && (
          <span className={`kpi-card__trend kpi-card__trend--${trend.direction}`}>
            <Icon name={trend.direction === 'up' ? 'trend-up-icon' : 'trend-down-icon'} size={12} />
            {trend.label}
          </span>
        )}
        {!trend && meta && <p className="kpi-card__meta">{meta}</p>}
      </div>
    </article>
  )
}

export default KpiCard
