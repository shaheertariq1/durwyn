import { useNavigate } from 'react-router-dom'
import Avatar from '../Avatar/Avatar.jsx'
import Badge from '../Badge/Badge.jsx'
import RowActionMenu from '../RowActionMenu/RowActionMenu.jsx'
import { planLabels, planTone, statusLabels, statusTone } from '../../data/mockSubscriptions.js'
import './SubscriptionsTable.css'

const COLUMNS = [
  { key: 'user', label: 'User' },
  { key: 'plan', label: 'Plan' },
  { key: 'status', label: 'Status' },
  { key: 'started', label: 'Started' },
  { key: 'renews', label: 'Renews' },
  { key: 'amount', label: 'Amount' },
]

function SubscriptionsTable({ subscriptions, onToggleSuspend, onCancel }) {
  const navigate = useNavigate()

  return (
    <div className="subscriptions-table" role="table" aria-label="Subscriptions">
      <div className="subscriptions-table__row subscriptions-table__row--head" role="row">
        {COLUMNS.map((column) => (
          <span key={column.key} className={`subscriptions-table__cell subscriptions-table__cell--${column.key}`}>
            {column.label}
          </span>
        ))}
        <span className="subscriptions-table__cell subscriptions-table__cell--actions">Actions</span>
      </div>

      <div className="subscriptions-table__body">
        {subscriptions.map((subscription) => (
          <div className="subscriptions-table__row" role="row" key={subscription.id}>
            <span className="subscriptions-table__cell subscriptions-table__cell--user">
              <Avatar name={subscription.name} size={24} />
              <span className="subscriptions-table__name">{subscription.name}</span>
            </span>
            <span className="subscriptions-table__cell subscriptions-table__cell--plan">
              <Badge tone={planTone[subscription.plan]}>{planLabels[subscription.plan]}</Badge>
            </span>
            <span className="subscriptions-table__cell subscriptions-table__cell--status">
              <Badge tone={statusTone[subscription.status]}>{statusLabels[subscription.status]}</Badge>
            </span>
            <span className="subscriptions-table__cell subscriptions-table__cell--started">
              {subscription.started}
            </span>
            <span className="subscriptions-table__cell subscriptions-table__cell--renews">
              {subscription.renews}
            </span>
            <span className="subscriptions-table__cell subscriptions-table__cell--amount subscriptions-table__amount">
              {subscription.amount > 0 ? `$${subscription.amount.toFixed(2)}` : 'Free'}
            </span>
            <span className="subscriptions-table__cell subscriptions-table__cell--actions">
              <RowActionMenu
                label={`Actions for ${subscription.name}'s subscription`}
                actions={[
                  { label: 'View user', onClick: () => navigate(`/dashboard/user/${subscription.userId}`) },
                  ...(subscription.status !== 'cancelled'
                    ? [
                        {
                          label: subscription.status === 'suspended' ? 'Reactivate subscription' : 'Suspend subscription',
                          onClick: () => onToggleSuspend(subscription.id),
                        },
                        {
                          label: 'Cancel subscription',
                          tone: 'red',
                          onClick: () => onCancel(subscription.id),
                        },
                      ]
                    : []),
                ]}
              />
            </span>
          </div>
        ))}

        {subscriptions.length === 0 && (
          <p className="subscriptions-table__empty">No subscriptions match the current search and filters.</p>
        )}
      </div>
    </div>
  )
}

export default SubscriptionsTable
