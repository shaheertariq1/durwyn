import { useMemo, useState } from 'react'
import Icon from '../../components/Icon/Icon.jsx'
import Tabs from '../../components/Tabs/Tabs.jsx'
import TicketList from '../../components/TicketList/TicketList.jsx'
import FaqAccordion from '../../components/FaqAccordion/FaqAccordion.jsx'
import DocumentationGrid from '../../components/DocumentationGrid/DocumentationGrid.jsx'
import Pagination from '../../components/Pagination/Pagination.jsx'
import { tickets, faqs, docLinks } from '../../data/mockHelpSupport.js'
import './HelpSupportPage.css'

const PAGE_SIZE = 8

const TAB_OPTIONS = [
  { value: 'tickets', label: 'tickets' },
  { value: 'faq', label: 'faq' },
  { value: 'documentation', label: 'Documentation' },
]

function HelpSupportPage() {
  const [tab, setTab] = useState('tickets')
  const [page, setPage] = useState(1)

  const pageCount = Math.max(1, Math.ceil(tickets.length / PAGE_SIZE))
  const safePage = Math.min(page, pageCount)
  const pageTickets = useMemo(
    () => tickets.slice((safePage - 1) * PAGE_SIZE, safePage * PAGE_SIZE),
    [safePage],
  )

  return (
    <div className="help-support-page">
      <h2 className="help-support-page__title">Help & Support</h2>

      <Tabs tabs={TAB_OPTIONS} value={tab} onChange={setTab} />

      {tab === 'tickets' && (
        <div className="help-support-page__panel">
          <div className="help-support-page__panel-head">
            <p className="help-support-page__panel-title">Support Tickets</p>
            <button type="button" className="help-support-page__new-ticket-button">
              <Icon name="action-add-icon" size={16} />
              New Ticket
            </button>
          </div>

          <TicketList tickets={pageTickets} />

          <Pagination
            page={safePage}
            pageCount={pageCount}
            totalCount={tickets.length}
            pageSize={PAGE_SIZE}
            onPageChange={setPage}
          />
        </div>
      )}

      {tab === 'faq' && (
        <div className="help-support-page__panel help-support-page__panel--faq">
          <FaqAccordion items={faqs} defaultOpenId={faqs[0]?.id} />
        </div>
      )}

      {tab === 'documentation' && <DocumentationGrid items={docLinks} />}
    </div>
  )
}

export default HelpSupportPage
