import './ChartCard.css'

function ChartCard({ title, subtitle, badge, children, className = '' }) {
  return (
    <section className={`chart-card ${className}`.trim()}>
      <div className="chart-card__head">
        <div className="chart-card__heading">
          <p className="chart-card__title">{title}</p>
          {subtitle && <p className="chart-card__subtitle">{subtitle}</p>}
        </div>
        {badge && <span className="chart-card__badge">{badge}</span>}
      </div>
      <div className="chart-card__body">{children}</div>
    </section>
  )
}

export default ChartCard
