import Badge from '../Badge/Badge.jsx'
import EmptyState from '../EmptyState/EmptyState.jsx'
import './PaymentHistoryList.css'

const STATUS_TONE = { success: 'green', failed: 'red' }
const STATUS_LABEL = { success: 'Success', failed: 'Failed' }

// "Payment History" card on the user detail Payments tab.
function PaymentHistoryList({ items }) {
  return (
    <div className="payment-history">
      <p className="payment-history__title">Payment History</p>
      {items.length === 0 ? (
        <EmptyState
          icon="nav-payments-icon"
          title="No payments on record"
          message="Successful and failed charges for this user will appear here."
        />
      ) : (
        <ul className="payment-history__list">
          {items.map((item) => (
            <li className="payment-history__row" key={item.id}>
              <div>
                <p className="payment-history__description">{item.description}</p>
                <p className="payment-history__date">{item.date}</p>
              </div>
              <div className="payment-history__amount-row">
                <span className="payment-history__amount">${item.amount.toFixed(2)}</span>
                <Badge tone={STATUS_TONE[item.status]}>{STATUS_LABEL[item.status]}</Badge>
              </div>
            </li>
          ))}
        </ul>
      )}
    </div>
  )
}

export default PaymentHistoryList
