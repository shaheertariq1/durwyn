import { useEffect, useRef, useState } from 'react'
import Icon from '../Icon/Icon.jsx'
import './RowActionMenu.css'

// "..." dropdown used on table rows (edit / suspend / delete style actions).
function RowActionMenu({ actions, label = 'Row actions' }) {
  const [open, setOpen] = useState(false)
  const ref = useRef(null)

  useEffect(() => {
    if (!open) return undefined

    function handlePointerDown(event) {
      if (ref.current && !ref.current.contains(event.target)) setOpen(false)
    }
    function handleKeyDown(event) {
      if (event.key === 'Escape') setOpen(false)
    }

    document.addEventListener('mousedown', handlePointerDown)
    document.addEventListener('keydown', handleKeyDown)
    return () => {
      document.removeEventListener('mousedown', handlePointerDown)
      document.removeEventListener('keydown', handleKeyDown)
    }
  }, [open])

  return (
    <div className="row-action-menu" ref={ref}>
      <button
        type="button"
        className="row-action-menu__trigger"
        aria-label={label}
        aria-haspopup="menu"
        aria-expanded={open}
        onClick={() => setOpen((current) => !current)}
      >
        <Icon name="action-more-icon" size={15} />
      </button>
      {open && (
        <div className="row-action-menu__panel" role="menu">
          {actions.map((action) => (
            <button
              key={action.label}
              type="button"
              role="menuitem"
              className={`row-action-menu__item${action.tone ? ` row-action-menu__item--${action.tone}` : ''}`}
              onClick={() => {
                setOpen(false)
                action.onClick()
              }}
            >
              {action.icon && <Icon name={action.icon} size={13} />}
              {action.label}
            </button>
          ))}
        </div>
      )}
    </div>
  )
}

export default RowActionMenu
