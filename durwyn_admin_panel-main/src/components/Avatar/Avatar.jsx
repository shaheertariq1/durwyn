import './Avatar.css'

const TONES = ['green', 'amber', 'red', 'blue', 'purple']

function toneFor(seed) {
  let hash = 0
  for (let i = 0; i < seed.length; i += 1) hash += seed.charCodeAt(i)
  return TONES[hash % TONES.length]
}

function initialsFor(name) {
  const parts = name.trim().split(/\s+/)
  return `${parts[0]?.[0] ?? ''}${parts[1]?.[0] ?? ''}`.toUpperCase()
}

// Initials avatar with a deterministic accent colour, used in the users table and profile header.
function Avatar({ name, size = 28, className = '' }) {
  const tone = toneFor(name)
  return (
    <span
      className={`avatar avatar--${tone} ${className}`.trim()}
      style={{ width: size, height: size, fontSize: size * 0.375 }}
    >
      {initialsFor(name)}
    </span>
  )
}

export default Avatar
