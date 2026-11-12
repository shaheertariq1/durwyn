import './Tabs.css'

// Bordered tab bar used on the user detail screen (Overview / Emergencies / Contacts / …).
function Tabs({ tabs, value, onChange }) {
  return (
    <div className="tabs" role="tablist">
      {tabs.map((tab) => (
        <button
          key={tab.value}
          type="button"
          role="tab"
          aria-selected={value === tab.value}
          className={`tabs__item${value === tab.value ? ' tabs__item--active' : ''}`}
          onClick={() => onChange(tab.value)}
        >
          {tab.label}
        </button>
      ))}
    </div>
  )
}

export default Tabs
