import { useState } from 'react'
import './ProcessRefundModal.css'

// Overlay form for refunding a payment, opened from the "Refund" row action
// on the payments table.
function ProcessRefundModal({ payment, onClose, onConfirm }) {
  const [reason, setReason] = useState('')

  function handleSubmit(event) {
    event.preventDefault()
    onConfirm(reason.trim())
  }

  return (
    <div className="process-refund-modal__overlay" onMouseDown={onClose}>
      <form
        className="process-refund-modal"
        role="dialog"
        aria-modal="true"
        aria-label="Process Refund"
        onMouseDown={(event) => event.stopPropagation()}
        onSubmit={handleSubmit}
      >
        <div className="process-refund-modal__header">
          <p className="process-refund-modal__title">Process Refund</p>
          <button type="button" className="process-refund-modal__close" onClick={onClose} aria-label="Close">
            ×
          </button>
        </div>

        <div className="process-refund-modal__body">
          <p className="process-refund-modal__notice">
            Refunding <strong>${payment.amount.toFixed(2)}</strong> to {payment.name}
          </p>

          <div className="process-refund-modal__field">
            <label className="process-refund-modal__label" htmlFor="process-refund-reason">
              Reason
            </label>
            <textarea
              id="process-refund-reason"
              className="process-refund-modal__textarea"
              placeholder="Reason…"
              value={reason}
              onChange={(event) => setReason(event.target.value)}
            />
          </div>
        </div>

        <div className="process-refund-modal__actions">
          <button
            type="button"
            className="process-refund-modal__button process-refund-modal__button--cancel"
            onClick={onClose}
          >
            Cancel
          </button>
          <button type="submit" className="process-refund-modal__button process-refund-modal__button--refund">
            Refund
          </button>
        </div>
      </form>
    </div>
  )
}

export default ProcessRefundModal
