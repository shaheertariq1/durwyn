import './Badge.css'

// Small pill used for plan / status / payment-result labels across the Users screens.
// `dot` adds a pulsing indicator (e.g. a live "Active" emergency).
function Badge({ tone = 'neutral', dot = false, children }) {
  return (
    <span className={`badge badge--${tone}`}>
      {dot && <span className="badge__dot" aria-hidden="true" />}
      {children}
    </span>
  )
}

export default Badge
