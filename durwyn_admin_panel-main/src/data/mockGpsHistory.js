// Local mock data standing in for the GPS History API. Keyed by the same
// userId used in src/data/mockUsers.js so the two stay in sync; swapping this
// module for a real fetch later is a drop-in change.

// `points` place breadcrumb dots on the map panel as percentages of the map
// box, so the trail scales with the panel instead of relying on fixed pixel
// coordinates. tone: 'start' | 'waypoint' | 'current'.
export const gpsHistoryByUserId = {
  U001: {
    live: true,
    playback: { start: '09:14', end: '14:22', progress: 65 },
    points: [
      { x: 19.8, y: 87.5, tone: 'start' },
      { x: 28.4, y: 68.8, tone: 'waypoint' },
      { x: 37.1, y: 50, tone: 'waypoint' },
      { x: 45.7, y: 50, tone: 'waypoint' },
      { x: 54.3, y: 31.3, tone: 'waypoint' },
      { x: 63, y: 12.5, tone: 'waypoint' },
      { x: 71.6, y: 31.3, tone: 'waypoint' },
      { x: 80.2, y: 68.8, tone: 'current' },
    ],
  },
  U002: {
    live: true,
    playback: { start: '08:02', end: '11:47', progress: 40 },
    points: [
      { x: 24, y: 82, tone: 'start' },
      { x: 34, y: 62, tone: 'waypoint' },
      { x: 48, y: 44, tone: 'waypoint' },
      { x: 58, y: 58, tone: 'waypoint' },
      { x: 68, y: 30, tone: 'current' },
    ],
  },
  U003: {
    live: false,
    playback: { start: '—', end: '—', progress: 0 },
    points: [{ x: 50, y: 50, tone: 'start' }],
  },
  U004: {
    live: true,
    playback: { start: '07:40', end: '13:05', progress: 78 },
    points: [
      { x: 16, y: 78, tone: 'start' },
      { x: 30, y: 60, tone: 'waypoint' },
      { x: 44, y: 66, tone: 'waypoint' },
      { x: 56, y: 40, tone: 'waypoint' },
      { x: 66, y: 22, tone: 'waypoint' },
      { x: 82, y: 34, tone: 'current' },
    ],
  },
  U005: {
    live: true,
    playback: { start: '10:12', end: '12:38', progress: 55 },
    points: [
      { x: 22, y: 70, tone: 'start' },
      { x: 40, y: 48, tone: 'waypoint' },
      { x: 60, y: 56, tone: 'waypoint' },
      { x: 76, y: 36, tone: 'current' },
    ],
  },
  U006: {
    live: true,
    playback: { start: '06:55', end: '09:30', progress: 20 },
    points: [
      { x: 30, y: 74, tone: 'start' },
      { x: 46, y: 52, tone: 'waypoint' },
      { x: 62, y: 60, tone: 'current' },
    ],
  },
}

export const gpsHistoryUserIds = ['U001', 'U002', 'U003', 'U004', 'U005', 'U006']
