// Renders a symbol from the shared /icons.svg sprite.
function Icon({ name, size = 20, width, height, className = '', ...rest }) {
  return (
    <svg
      className={`icon ${className}`.trim()}
      width={width ?? size}
      height={height ?? size}
      role="presentation"
      aria-hidden="true"
      {...rest}
    >
      <use href={`/icons.svg#${name}`} />
    </svg>
  )
}

export default Icon
