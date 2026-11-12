import './InfoList.css'

// Label/value rows, e.g. the "Personal Info" card on the user overview tab.
function InfoList({ title, rows }) {
  return (
    <div className="info-list">
      <p className="info-list__title">{title}</p>
      <dl className="info-list__rows">
        {rows.map((row) => (
          <div className="info-list__row" key={row.label}>
            <dt>{row.label}</dt>
            <dd>{row.value}</dd>
          </div>
        ))}
      </dl>
    </div>
  )
}

export default InfoList
