import Badge from '../Badge/Badge.jsx'
import Icon from '../Icon/Icon.jsx'
import { planLabels } from '../../data/mockSubscriptions.js'
import { statusLabels, statusTone } from '../../data/mockPayments.js'
import './InvoiceModal.css'

const ROWS = [
  { key: 'user', label: 'User', value: (payment) => payment.name },
  { key: 'plan', label: 'Plan', value: (payment) => planLabels[payment.plan] },
  { key: 'amount', label: 'Amount', value: (payment) => `$${payment.amount.toFixed(2)}` },
  { key: 'method', label: 'Method', value: (payment) => payment.method },
  { key: 'date', label: 'Date', value: (payment) => payment.date },
]

function invoiceNumberFor(payment) {
  return `INV-${payment.date.replaceAll('-', '')}-${payment.id.slice(3)}`
}

function downloadInvoice(payment) {
  const lines = [
    `Invoice ${invoiceNumberFor(payment)}`,
    `Status: ${statusLabels[payment.status]}`,
    `User: ${payment.name}`,
    `Plan: ${planLabels[payment.plan]}`,
    `Amount: $${payment.amount.toFixed(2)}`,
    `Method: ${payment.method}`,
    `Date: ${payment.date}`,
  ]
  const blob = new Blob([lines.join('\n')], { type: 'text/plain;charset=utf-8;' })
  const url = URL.createObjectURL(blob)
  const link = document.createElement('a')
  link.href = url
  link.download = `${invoiceNumberFor(payment)}.txt`
  link.click()
  URL.revokeObjectURL(url)
}

// Read-only invoice summary opened from the "View Invoice" row action.
function InvoiceModal({ payment, onClose }) {
  return (
    <div className="invoice-modal__overlay" onMouseDown={onClose}>
      <div
        className="invoice-modal"
        role="dialog"
        aria-modal="true"
        aria-label="Invoice"
        onMouseDown={(event) => event.stopPropagation()}
      >
        <div className="invoice-modal__header">
          <p className="invoice-modal__title">Invoice</p>
          <button type="button" className="invoice-modal__close" onClick={onClose} aria-label="Close">
            ×
          </button>
        </div>

        <div className="invoice-modal__body">
          <div className="invoice-modal__summary">
            <span className="invoice-modal__number">{invoiceNumberFor(payment)}</span>
            <Badge tone={statusTone[payment.status]}>{statusLabels[payment.status]}</Badge>
          </div>

          {ROWS.map((row) => (
            <div className="invoice-modal__row" key={row.key}>
              <span className="invoice-modal__label">{row.label}</span>
              <span className="invoice-modal__value">{row.value(payment)}</span>
            </div>
          ))}

          <button type="button" className="invoice-modal__download" onClick={() => downloadInvoice(payment)}>
            <Icon name="action-export-icon" size={13} />
            Download PDF
          </button>
        </div>
      </div>
    </div>
  )
}

export default InvoiceModal
