import { useMemo, useState } from 'react'
import Icon from '../../components/Icon/Icon.jsx'
import ReportTypeCard from '../../components/ReportTypeCard/ReportTypeCard.jsx'
import ReportsTable from '../../components/ReportsTable/ReportsTable.jsx'
import SearchInput from '../../components/SearchInput/SearchInput.jsx'
import Pagination from '../../components/Pagination/Pagination.jsx'
import { reportTypes, reportConfigs } from '../../data/mockReports.js'
import './ReportsPage.css'

const PAGE_SIZE = 8

const EXPORT_FORMATS = [
  { id: 'pdf', label: 'PDF', icon: 'report-export-pdf-icon' },
  { id: 'excel', label: 'Excel', icon: 'report-export-excel-icon' },
  { id: 'csv', label: 'CSV', icon: 'report-export-csv-icon' },
  { id: 'print', label: 'Print', icon: 'report-export-print-icon' },
]

function downloadCsv(filename, columns, rows) {
  const header = columns.map((column) => column.label)
  const lines = rows.map((row) =>
    columns
      .map((column) => {
        const value = column.format ? column.format(row[column.key], row) : row[column.key]
        return `"${String(value).replace(/"/g, '""')}"`
      })
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

function ReportsPage() {
  const [activeReportId, setActiveReportId] = useState(reportTypes[0].id)
  const [search, setSearch] = useState('')
  const [fromDate, setFromDate] = useState('')
  const [toDate, setToDate] = useState('')
  const [appliedRange, setAppliedRange] = useState({ from: '', to: '' })
  const [page, setPage] = useState(1)

  const activeConfig = reportConfigs[activeReportId]
  const activeType = reportTypes.find((type) => type.id === activeReportId)

  function selectReport(id) {
    setActiveReportId(id)
    setSearch('')
    setFromDate('')
    setToDate('')
    setAppliedRange({ from: '', to: '' })
    setPage(1)
  }

  function updateSearch(value) {
    setSearch(value)
    setPage(1)
  }

  function generateReport() {
    setAppliedRange({ from: fromDate, to: toDate })
    setPage(1)
  }

  const filteredRows = useMemo(() => {
    const term = search.trim().toLowerCase()
    return activeConfig.rows.filter((row) => {
      const matchesSearch =
        term.length === 0 ||
        activeConfig.searchKeys.some((key) => String(row[key]).toLowerCase().includes(term))
      if (!matchesSearch) return false

      if (!activeConfig.dateKey) return true
      const value = row[activeConfig.dateKey]
      if (appliedRange.from && value < appliedRange.from) return false
      if (appliedRange.to && value > appliedRange.to) return false
      return true
    })
  }, [activeConfig, search, appliedRange])

  const pageCount = Math.max(1, Math.ceil(filteredRows.length / PAGE_SIZE))
  const safePage = Math.min(page, pageCount)
  const pageRows = filteredRows.slice((safePage - 1) * PAGE_SIZE, safePage * PAGE_SIZE)

  function handleExport(formatId) {
    if (formatId === 'print') {
      window.print()
      return
    }
    if (formatId === 'csv') {
      downloadCsv(`${activeReportId}-report.csv`, activeConfig.columns, filteredRows)
    }
    // PDF/Excel export isn't specified in the source design and would require
    // a new dependency to generate real files, so those buttons stay visual-only.
  }

  return (
    <div className="reports-page">
      <h2 className="reports-page__title">Reports</h2>

      <div className="reports-page__grid">
        {reportTypes.map((type) => (
          <ReportTypeCard
            key={type.id}
            label={type.label}
            icon={type.icon}
            tint={type.tint}
            records={reportConfigs[type.id].rows.length}
            active={type.id === activeReportId}
            onClick={() => selectReport(type.id)}
          />
        ))}
      </div>

      <div className="reports-page__panel">
        <div className="reports-page__panel-head">
          <p className="reports-page__panel-title">{activeType.label}</p>
          <div className="reports-page__export-group">
            {EXPORT_FORMATS.map((format) => (
              <button
                key={format.id}
                type="button"
                className="reports-page__export-button"
                onClick={() => handleExport(format.id)}
                aria-label={`Export as ${format.label}`}
              >
                <Icon name={format.icon} size={11} />
                {format.label}
              </button>
            ))}
          </div>
        </div>

        <div className="reports-page__toolbar">
          <SearchInput
            value={search}
            onChange={(event) => updateSearch(event.target.value)}
            placeholder="Search report…"
            className="reports-page__search"
          />

          {activeConfig.dateKey && (
            <>
              <div className="reports-page__date-field">
                <label htmlFor="reports-from-date">From</label>
                <input
                  id="reports-from-date"
                  type="date"
                  value={fromDate}
                  onChange={(event) => setFromDate(event.target.value)}
                />
              </div>
              <div className="reports-page__date-field">
                <label htmlFor="reports-to-date">To</label>
                <input
                  id="reports-to-date"
                  type="date"
                  value={toDate}
                  onChange={(event) => setToDate(event.target.value)}
                />
              </div>
            </>
          )}

          <button type="button" className="reports-page__generate-button" onClick={generateReport}>
            Generate
          </button>
        </div>

        <div className="reports-page__table-scroll">
          <ReportsTable columns={activeConfig.columns} rows={pageRows} />
        </div>

        <Pagination
          page={safePage}
          pageCount={pageCount}
          totalCount={filteredRows.length}
          pageSize={PAGE_SIZE}
          onPageChange={setPage}
        />
      </div>
    </div>
  )
}

export default ReportsPage
