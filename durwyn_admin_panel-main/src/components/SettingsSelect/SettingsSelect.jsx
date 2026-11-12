import Icon from '../Icon/Icon.jsx'
import './SettingsSelect.css'

// Labeled dropdown styled like the Settings screen's text inputs, used for
// Session Timeout / Platform Name / Language / Timezone / Data Retention.
function SettingsSelect({ id, label, value, onChange, options }) {
  return (
    <div className="settings-select">
      <label className="settings-select__label" htmlFor={id}>
        {label}
      </label>
      <div className="settings-select__control">
        <select id={id} className="settings-select__input" value={value} onChange={onChange}>
          {options.map((option) => (
            <option key={option} value={option}>
              {option}
            </option>
          ))}
        </select>
        <Icon name="chevron-down-icon" size={10} className="settings-select__chevron" />
      </div>
    </div>
  )
}

export default SettingsSelect
