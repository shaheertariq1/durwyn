import { useMemo, useState } from 'react'
import Icon from '../../components/Icon/Icon.jsx'
import KpiCard from '../../components/KpiCard/KpiCard.jsx'
import Tabs from '../../components/Tabs/Tabs.jsx'
import SubscriptionsTable from '../../components/SubscriptionsTable/SubscriptionsTable.jsx'
import Pagination from '../../components/Pagination/Pagination.jsx'
import { kpiSummary, subscriptions as initialSubscriptions } from '../../data/mockSubscriptions.js'
import './SubscriptionPage.css'

const PAGE_SIZE = 8

const TABS = [
  { value: 'overview', label: 'overview' },
  { value: 'expiring', label: 'expiring' },
  { value: 'cancelled', label: 'cancelled' },
]

function SubscriptionPage() {
  const [subscriptions, setSubscriptions] = useState(initialSubscriptions)
  const [tab, setTab] = useState('overview')
  const [page, setPage] = useState(1)

  const tabFiltered = useMemo(() => {
    if (tab === 'expiring') return subscriptions.filter((subscription) => subscription.expiringSoon)
    if (tab === 'cancelled') return subscriptions.filter((subscription) => subscription.status === 'cancelled')
    return subscriptions
  }, [subscriptions, tab])

  const pageCount = Math.max(1, Math.ceil(tabFiltered.length / PAGE_SIZE))
  const safePage = Math.min(page, pageCount)
  const pageSubscriptions = tabFiltered.slice((safePage - 1) * PAGE_SIZE, safePage * PAGE_SIZE)

  function updateTab(value) {
    setTab(value)
    setPage(1)
  }

  function toggleSuspend(id) {
    setSubscriptions((current) =>
      current.map((subscription) =>
        subscription.id === id
          ? { ...subscription, status: subscription.status === 'suspended' ? 'active' : 'suspended' }
          : subscription,
      ),
    )
  }

  function cancelSubscription(id) {
    setSubscriptions((current) =>
      current.map((subscription) =>
        subscription.id === id ? { ...subscription, status: 'cancelled', expiringSoon: false, renews: '—' } : subscription,
      ),
    )
  }

  return (
    <div className="subscription-page">
      <div className="subscription-page__header">
        <h2 className="subscription-page__title">Subscription Management</h2>
        <button type="button" className="subscription-page__assign-button">
          <Icon name="action-add-icon" size={13} />
          Assign Plan
        </button>
      </div>

      <div className="subscription-page__kpi-grid">
        {kpiSummary.map((kpi) => (
          <KpiCard
            key={kpi.id}
            label={kpi.label}
            value={kpi.value}
            icon={kpi.icon}
            tint={kpi.tint}
            meta={kpi.meta}
          />
        ))}
      </div>

      <Tabs tabs={TABS} value={tab} onChange={updateTab} />

      <div className="subscription-page__panel">
        <div className="subscription-page__table-scroll">
          <SubscriptionsTable
            subscriptions={pageSubscriptions}
            onToggleSuspend={toggleSuspend}
            onCancel={cancelSubscription}
          />
        </div>

        <Pagination
          page={safePage}
          pageCount={pageCount}
          totalCount={tabFiltered.length}
          pageSize={PAGE_SIZE}
          onPageChange={setPage}
        />
      </div>
    </div>
  )
}

export default SubscriptionPage
