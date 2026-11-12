import Icon from '../Icon/Icon.jsx'
import './TextField.css'

// Labeled input with a leading icon and an optional trailing control (e.g. password toggle).
function TextField({
  id,
  label,
  icon,
  error,
  trailing,
  className = '',
  ...inputProps
}) {
  const errorId = error ? `${id}-error` : undefined

  return (
    <div className={`text-field ${className}`.trim()}>
      <label className="text-field__label" htmlFor={id}>
        {label}
      </label>
      <div
        className={`text-field__control${error ? ' text-field__control--error' : ''}`}
      >
        <Icon name={icon} size={20} className="text-field__icon" />
        <input
          id={id}
          className="text-field__input"
          aria-invalid={error ? 'true' : 'false'}
          aria-describedby={errorId}
          {...inputProps}
        />
        {trailing}
      </div>
      {error && (
        <p className="text-field__error" id={errorId} role="alert">
          {error}
        </p>
      )}
    </div>
  )
}

export default TextField
