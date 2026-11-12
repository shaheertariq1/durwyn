import Icon from '../Icon/Icon.jsx'
import './SettingsField.css'

// Labeled input used across the Settings tabs. `prominent` switches to the
// larger gray label + icon-leading style used on the Password tab; the
// default is the compact style used on the Profile tab.
function SettingsField({ id, label, icon, trailing, prominent = false, filled = false, className = '', ...inputProps }) {
  return (
    <div
      className={`settings-field${prominent ? ' settings-field--prominent' : ''} ${className}`.trim()}
    >
      <label className="settings-field__label" htmlFor={id}>
        {label}
      </label>
      <div className={`settings-field__control${filled ? ' settings-field__control--filled' : ''}`}>
        {icon && <Icon name={icon} size={20} className="settings-field__icon" />}
        <input id={id} className="settings-field__input" {...inputProps} />
        {trailing}
      </div>
    </div>
  )
}

export default SettingsField
