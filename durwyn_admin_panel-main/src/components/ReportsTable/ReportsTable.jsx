import './ReportsTable.css'

// Config-driven table shared by all 6 report types on the Reports screen —
// each type only differs by its `columns`/`rows` shape, so one generic grid
// renders all of them instead of six near-identical bespoke tables.
function ReportsTable({ columns, rows, emptyMessage = 'No records match the current search and filters.' }) {
  return (
    <div className="reports-table" role="table" aria-label="Report results">
      <div
        className="reports-table__row reports-table__row--head"
        role="row"
        style={{ gridTemplateColumns: `repeat(${columns.length}, minmax(100px, 1fr))` }}
      >
        {columns.map((column) => (
          <span key={column.key} className="reports-table__cell">
            {column.label}
          </span>
        ))}
      </div>

      <div className="reports-table__body">
        {rows.map((row, index) => (
          <div
            className="reports-table__row"
            role="row"
            key={row.id ?? index}
            style={{ gridTemplateColumns: `repeat(${columns.length}, minmax(100px, 1fr))` }}
          >
            {columns.map((column) => (
              <span
                key={column.key}
                className={`reports-table__cell${column.mono ? ' reports-table__mono' : ''}`}
              >
                {column.format ? column.format(row[column.key], row) : row[column.key]}
              </span>
            ))}
          </div>
        ))}

        {rows.length === 0 && <p className="reports-table__empty">{emptyMessage}</p>}
      </div>
    </div>
  )
}

export default ReportsTable
