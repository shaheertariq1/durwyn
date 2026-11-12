import './FilterPills.css'

// Compact single-select pill group, e.g. the plan/status filter row above the users table.
function FilterPills({ options, value, onChange, className = '' }) {
  return (
    <div className={`filter-pills ${className}`.trim()} role="group">
      {options.map((option) => (
        <button
          key={option.value}
          type="button"
          className={`filter-pills__item${value === option.value ? ' filter-pills__item--active' : ''}`}
          aria-pressed={value === option.value}
          onClick={() => onChange(option.value)}
        >
          {option.label}
        </button>
      ))}
    </div>
  )
}

export default FilterPills
