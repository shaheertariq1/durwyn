import Avatar from '../Avatar/Avatar.jsx'
import Badge from '../Badge/Badge.jsx'
import RowActionMenu from '../RowActionMenu/RowActionMenu.jsx'
import { planLabels, planTone } from '../../data/mockSubscriptions.js'
import { statusLabels, statusTone } from '../../data/mockPayments.js'
import './PaymentsTable.css'

const COLUMNS = [
  { key: 'id', label: 'ID' },
  { key: 'user', label: 'User' },
  { key: 'plan', label: 'Plan' },
  { key: 'amount', label: 'Amount' },
  { key: 'method', label: 'Method' },
  { key: 'status', label: 'Status' },
  { key: 'date', label: 'Date' },
]

function PaymentsTable({ payments, onViewInvoice, onRefund, onExport }) {
  return (
    <div className="payments-table" role="table" aria-label="Payments">
      <div className="payments-table__row payments-table__row--head" role="row">
        {COLUMNS.map((column) => (
          <span key={column.key} className={`payments-table__cell payments-table__cell--${column.key}`}>
            {column.label}
          </span>
        ))}
        <span className="payments-table__cell payments-table__cell--actions">Actions</span>
      </div>

      <div className="payments-table__body">
        {payments.map((payment) => (
          <div className="payments-table__row" role="row" key={payment.id}>
            <span className="payments-table__cell payments-table__cell--id payments-table__mono">
              {payment.id}
            </span>
            <span className="payments-table__cell payments-table__cell--user">
              <Avatar name={payment.name} size={24} />
              <span className="payments-table__name">{payment.name}</span>
            </span>
            <span className="payments-table__cell payments-table__cell--plan">
              <Badge tone={planTone[payment.plan]}>{planLabels[payment.plan]}</Badge>
            </span>
            <span className="payments-table__cell payments-table__cell--amount payments-table__amount">
              ${payment.amount.toFixed(2)}
            </span>
            <span className="payments-table__cell payments-table__cell--method">{payment.method}</span>
            <span className="payments-table__cell payments-table__cell--status">
              <Badge tone={statusTone[payment.status]}>{statusLabels[payment.status]}</Badge>
            </span>
            <span className="payments-table__cell payments-table__cell--date">{payment.date}</span>
            <span className="payments-table__cell payments-table__cell--actions">
              <RowActionMenu
                label={`Actions for payment ${payment.id}`}
                actions={[
                  { label: 'View Invoice', icon: 'empty-document-icon', onClick: () => onViewInvoice(payment) },
                  ...(payment.status === 'success'
                    ? [{ label: 'Refund', icon: 'action-refresh-icon', onClick: () => onRefund(payment) }]
                    : []),
                  { label: 'Export', icon: 'action-export-icon', onClick: () => onExport(payment) },
                ]}
              />
            </span>
          </div>
        ))}

        {payments.length === 0 && (
          <p className="payments-table__empty">No transactions match the current search and filters.</p>
        )}
      </div>
    </div>
  )
}

export default PaymentsTable
