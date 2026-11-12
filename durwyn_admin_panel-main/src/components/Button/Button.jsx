import './Button.css'

function Button({
  children,
  type = 'button',
  variant = 'primary',
  loading = false,
  loadingText,
  disabled = false,
  className = '',
  ...rest
}) {
  return (
    <button
      type={type}
      className={`button button--${variant} ${className}`.trim()}
      disabled={disabled || loading}
      aria-busy={loading}
      {...rest}
    >
      {loading ? loadingText ?? children : children}
    </button>
  )
}

export default Button
