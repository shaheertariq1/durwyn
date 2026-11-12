import { useEffect } from 'react'
import Icon from '../Icon/Icon.jsx'
import './Toast.css'

// Auto-dismissing success banner, e.g. shown after a contact status change.
function Toast({ message, onClose, duration = 3000 }) {
  useEffect(() => {
    const timer = window.setTimeout(onClose, duration)
    return () => window.clearTimeout(timer)
  }, [onClose, duration])

  return (
    <div className="toast toast--green" role="status">
      <Icon name="check-circle-icon" size={16} className="toast__icon" />
      <p className="toast__message">{message}</p>
      <button type="button" className="toast__close" onClick={onClose} aria-label="Dismiss">
        ×
      </button>
    </div>
  )
}

export default Toast
