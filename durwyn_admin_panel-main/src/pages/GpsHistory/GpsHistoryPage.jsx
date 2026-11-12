import { useMemo, useState } from 'react'
import UserGpsList from '../../components/UserGpsList/UserGpsList.jsx'
import GpsMapPanel from '../../components/GpsMapPanel/GpsMapPanel.jsx'
import { users } from '../../data/mockUsers.js'
import { gpsHistoryByUserId, gpsHistoryUserIds } from '../../data/mockGpsHistory.js'
import './GpsHistoryPage.css'

const gpsUsers = gpsHistoryUserIds
  .map((id) => users.find((user) => user.id === id))
  .filter(Boolean)

function GpsHistoryPage() {
  const [selectedUserId, setSelectedUserId] = useState(gpsUsers[0]?.id)

  const selectedUser = useMemo(
    () => gpsUsers.find((user) => user.id === selectedUserId) ?? gpsUsers[0],
    [selectedUserId],
  )
  const history = gpsHistoryByUserId[selectedUser.id]

  return (
    <div className="gps-history-page">
      <h2 className="gps-history-page__title">GPS History</h2>
      <div className="gps-history-page__layout">
        <UserGpsList users={gpsUsers} selectedUserId={selectedUser.id} onSelect={setSelectedUserId} />
        <GpsMapPanel user={selectedUser} history={history} />
      </div>
    </div>
  )
}

export default GpsHistoryPage
