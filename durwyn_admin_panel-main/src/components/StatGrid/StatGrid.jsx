import './StatGrid.css'

// 2-column grid of colour-coded number tiles, e.g. the "Statistics" card on the user overview tab.
function StatGrid({ title, stats }) {
  return (
    <div className="stat-grid">
      <p className="stat-grid__title">{title}</p>
      <div className="stat-grid__tiles">
        {stats.map((stat) => (
          <div className="stat-grid__tile" key={stat.label}>
            <p className="stat-grid__value" style={{ color: stat.color }}>
              {stat.value}
            </p>
            <p className="stat-grid__label">{stat.label}</p>
          </div>
        ))}
      </div>
    </div>
  )
}

export default StatGrid
