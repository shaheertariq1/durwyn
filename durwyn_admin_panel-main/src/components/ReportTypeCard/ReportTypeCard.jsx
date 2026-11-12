import Icon from '../Icon/Icon.jsx'
import './ReportTypeCard.css'

// Selectable card in the Reports grid — clicking one swaps the results panel below.
function ReportTypeCard({ label, icon, tint, records, active, onClick }) {
  return (
    <button
      type="button"
      className={`report-type-card${active ? ' report-type-card--active' : ''}`}
      aria-pressed={active}
      onClick={onClick}
    >
      <span className={`report-type-card__icon report-type-card__icon--${tint}`}>
        <Icon name={icon} size={17} />
      </span>
      <span className="report-type-card__label">{label}</span>
      <span className="report-type-card__meta">{records} records</span>
    </button>
  )
}

export default ReportTypeCard
