import { useMemo, useState } from 'react'
import Icon from '../../components/Icon/Icon.jsx'
import KpiCard from '../../components/KpiCard/KpiCard.jsx'
import Tabs from '../../components/Tabs/Tabs.jsx'
import SearchInput from '../../components/SearchInput/SearchInput.jsx'
import FilterPills from '../../components/FilterPills/FilterPills.jsx'
import PaymentsTable from '../../components/PaymentsTable/PaymentsTable.jsx'
import Pagination from '../../components/Pagination/Pagination.jsx'
import InvoiceModal from '../../components/InvoiceModal/InvoiceModal.jsx'
import ProcessRefundModal from '../../components/ProcessRefundModal/ProcessRefundModal.jsx'
import Toast from '../../components/Toast/Toast.jsx'
import { kpiSummary, payments as initialPayments, statusLabels } from '../../data/mockPayments.js'
import { subscriptions } from '../../data/mockSubscriptions.js'
import './PaymentsPage.css'

const PAGE_SIZE = 8

const TABS = [
  { value: 'overview', label: 'overview' },
  { value: 'expiring', label: 'expiring' },
  { value: 'cancelled', label: 'cancelled' },
]

const STATUS_FILTERS = [
  { value: 'all', label: 'all' },
  { value: 'success', label: statusLabels.success.toLowerCase() },
  { value: 'failed', label: statusLabels.failed.toLowerCase() },
  { value: 'refunded', label: statusLabels.refunded.toLowerCase() },
]

function downloadCsv(rows, filename = 'payments.csv') {
  const header = ['ID', 'User', 'Plan', 'Amount', 'Method', 'Status', 'Date']
  const lines = rows.map((payment) =>
    [payment.id, payment.name, payment.plan, payment.amount.toFixed(2), payment.method, payment.status, payment.date]
      .map((value) => `"${String(value).replace(/"/g, '""')}"`)
      .join(','),
  )
  const csv = [header.join(','), ...lines].join('\n')
  const blob = new Blob([csv], { type: 'text/csv;charset=utf-8;' })
  const url = URL.createObjectURL(blob)
  const link = document.createElement('a')
  link.href = url
  link.download = filename
  link.click()
  URL.revokeObjectURL(url)
}

function PaymentsPage() {
  const [payments, setPayments] = useState(initialPayments)
  const [tab, setTab] = useState('overview')
  const [status, setStatus] = useState('all')
  const [search, setSearch] = useState('')
  const [page, setPage] = useState(1)
  const [invoiceId, setInvoiceId] = useState(null)
  const [refundingId, setRefundingId] = useState(null)
  const [toast, setToast] = useState(null)

  const subscriptionByUserId = useMemo(() => {
    const map = new Map()
    subscriptions.forEach((subscription) => map.set(subscription.userId, subscription))
    return map
  }, [])

  const tabFiltered = useMemo(() => {
    if (tab === 'expiring') {
      return payments.filter((payment) => subscriptionByUserId.get(payment.userId)?.expiringSoon)
    }
    if (tab === 'cancelled') {
      return payments.filter((payment) => subscriptionByUserId.get(payment.userId)?.status === 'cancelled')
    }
    return payments
  }, [payments, tab, subscriptionByUserId])

  const statusFiltered = useMemo(() => {
    if (status === 'all') return tabFiltered
    return tabFiltered.filter((payment) => payment.status === status)
  }, [tabFiltered, status])

  const filteredPayments = useMemo(() => {
    const term = search.trim().toLowerCase()
    if (term.length === 0) return statusFiltered
    return statusFiltered.filter(
      (payment) => payment.name.toLowerCase().includes(term) || payment.id.toLowerCase().includes(term),
    )
  }, [statusFiltered, search])

  const pageCount = Math.max(1, Math.ceil(filteredPayments.length / PAGE_SIZE))
  const safePage = Math.min(page, pageCount)
  const pagePayments = filteredPayments.slice((safePage - 1) * PAGE_SIZE, safePage * PAGE_SIZE)

  function updateSearch(value) {
    setSearch(value)
    setPage(1)
  }

  function updateTab(value) {
    setTab(value)
    setPage(1)
  }

  function updateStatus(value) {
    setStatus(value)
    setPage(1)
  }

  function confirmRefund(reason) {
    const payment = payments.find((candidate) => candidate.id === refundingId)
    if (!payment) return
    setPayments((current) =>
      current.map((candidate) => (candidate.id === refundingId ? { ...candidate, status: 'refunded' } : candidate)),
    )
    setRefundingId(null)
    setToast(`Refund issued for ${payment.id}${reason ? ` — ${reason}` : ''}.`)
  }

  const invoicePayment = payments.find((payment) => payment.id === invoiceId) ?? null
  const refundingPayment = payments.find((payment) => payment.id === refundingId) ?? null

  return (
    <div className="payments-page">
      <div className="payments-page__header">
        <h2 className="payments-page__title">Payment Management</h2>
        <button
          type="button"
          className="payments-page__export-button"
          onClick={() => downloadCsv(filteredPayments)}
        >
          <Icon name="action-export-icon" size={13} />
          Export
        </button>
      </div>

      <div className="payments-page__kpi-grid">
        {kpiSummary.map((kpi) => (
          <KpiCard
            key={kpi.id}
            label={kpi.label}
            value={kpi.value}
            icon={kpi.icon}
            tint={kpi.tint}
            valueTone={kpi.valueTone}
          />
        ))}
      </div>

      <Tabs tabs={TABS} value={tab} onChange={updateTab} />

      <div className="payments-page__panel">
        <div className="payments-page__toolbar">
          <SearchInput
            value={search}
            onChange={(event) => updateSearch(event.target.value)}
            placeholder="Search transactions…"
            className="payments-page__search"
          />
          <FilterPills options={STATUS_FILTERS} value={status} onChange={updateStatus} />
        </div>

        <div className="payments-page__table-scroll">
          <PaymentsTable
            payments={pagePayments}
            onViewInvoice={(payment) => setInvoiceId(payment.id)}
            onRefund={(payment) => setRefundingId(payment.id)}
            onExport={(payment) => downloadCsv([payment], `${payment.id}.csv`)}
          />
        </div>

        <Pagination
          page={safePage}
          pageCount={pageCount}
          totalCount={filteredPayments.length}
          pageSize={PAGE_SIZE}
          onPageChange={setPage}
        />
      </div>

      {invoicePayment && <InvoiceModal payment={invoicePayment} onClose={() => setInvoiceId(null)} />}

      {refundingPayment && (
        <ProcessRefundModal
          payment={refundingPayment}
          onClose={() => setRefundingId(null)}
          onConfirm={confirmRefund}
        />
      )}

      {toast && <Toast message={toast} onClose={() => setToast(null)} />}
    </div>
  )
}

export default PaymentsPage
