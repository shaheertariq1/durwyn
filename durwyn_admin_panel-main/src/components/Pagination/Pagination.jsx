import Icon from '../Icon/Icon.jsx'
import './Pagination.css'

// Prev/next + page-number pagination, shown under the users table.
function Pagination({ page, pageCount, totalCount, pageSize, onPageChange }) {
  if (totalCount === 0) return null

  const start = (page - 1) * pageSize + 1
  const end = Math.min(page * pageSize, totalCount)

  return (
    <div className="pagination">
      <p className="pagination__summary">
        Showing {start}–{end} of {totalCount}
      </p>
      <div className="pagination__controls">
        <button
          type="button"
          className="pagination__button"
          disabled={page <= 1}
          aria-label="Previous page"
          onClick={() => onPageChange(page - 1)}
        >
          <Icon name="chevron-left-icon" size={14} />
        </button>
        {Array.from({ length: pageCount }, (_, index) => index + 1).map((pageNumber) => (
          <button
            key={pageNumber}
            type="button"
            className={`pagination__button${pageNumber === page ? ' pagination__button--active' : ''}`}
            aria-current={pageNumber === page ? 'page' : undefined}
            onClick={() => onPageChange(pageNumber)}
          >
            {pageNumber}
          </button>
        ))}
        <button
          type="button"
          className="pagination__button"
          disabled={page >= pageCount}
          aria-label="Next page"
          onClick={() => onPageChange(page + 1)}
        >
          <Icon name="chevron-right-icon" size={14} />
        </button>
      </div>
    </div>
  )
}

export default Pagination
