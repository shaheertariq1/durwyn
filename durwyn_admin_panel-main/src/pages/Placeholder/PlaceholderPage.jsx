import EmptyState from '../../components/EmptyState/EmptyState.jsx'

function PlaceholderPage({ title, icon }) {
  return (
    <EmptyState
      icon={icon}
      title={`${title} is coming soon`}
      message="This section hasn't been designed yet. Check back once it ships."
    />
  )
}

export default PlaceholderPage
