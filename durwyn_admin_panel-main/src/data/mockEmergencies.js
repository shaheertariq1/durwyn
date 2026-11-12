// Local mock data standing in for the Emergency Monitoring API. Components only
// consume the shapes below, so swapping this module for a real fetch later is a
// drop-in change. `userId` cross-references src/data/mockUsers.js where the names match.

export const emergencies = [
  {
    id: 'EM-1201',
    userId: 'U001',
    name: 'Sarah Mitchell',
    type: 'Medical',
    priority: 'high',
    status: 'active',
    duration: '00:12:34',
    started: '2024-07-15 14:22',
    contact: 'Tom Mitchell',
    response: 'responded',
  },
  {
    id: 'EM-1198',
    userId: 'U004',
    name: 'Daniel Rivera',
    type: 'Physical Assault',
    priority: 'critical',
    status: 'resolved',
    duration: '00:08:15',
    started: '2024-07-14 21:45',
    contact: 'Maria Rivera',
    response: 'responded',
  },
  {
    id: 'EM-1189',
    userId: 'U010',
    name: 'Kwame Asante',
    type: 'Fire',
    priority: 'high',
    status: 'resolved',
    duration: '00:04:50',
    started: '2024-07-14 09:10',
    contact: 'Ama Asante',
    response: 'responded',
  },
  {
    id: 'EM-1177',
    userId: 'U007',
    name: 'Lena Fischer',
    type: 'Medical',
    priority: 'medium',
    status: 'cancelled',
    duration: '00:00:45',
    started: '2024-07-13 16:38',
    contact: 'Hans Fischer',
    response: 'pending',
  },
  {
    id: 'EM-1162',
    userId: 'U005',
    name: 'Priya Nair',
    type: 'Home Intrusion',
    priority: 'critical',
    status: 'resolved',
    duration: '00:22:10',
    started: '2024-07-12 23:05',
    contact: 'Raj Nair',
    response: 'responded',
  },
  {
    id: 'EM-1202',
    userId: 'U002',
    name: 'James Carter',
    type: 'Vehicle Accident',
    priority: 'high',
    status: 'active',
    duration: '00:05:22',
    started: '2024-07-15 12:14',
    contact: 'Linda Carter',
    response: 'pending',
  },
  {
    id: 'EM-1150',
    userId: 'U003',
    name: 'Amara Osei',
    type: 'Fall Detected',
    priority: 'medium',
    status: 'resolved',
    duration: '00:03:12',
    started: '2024-07-11 07:52',
    contact: 'Kofi Osei',
    response: 'responded',
  },
  {
    id: 'EM-1141',
    userId: 'U006',
    name: 'Marcus Webb',
    type: 'Medical',
    priority: 'low',
    status: 'cancelled',
    duration: '00:01:05',
    started: '2024-07-10 19:30',
    contact: 'Alicia Webb',
    response: 'pending',
  },
  {
    id: 'EM-1132',
    userId: 'U008',
    name: 'Omar Hassan',
    type: 'Panic Button',
    priority: 'high',
    status: 'resolved',
    duration: '00:06:40',
    started: '2024-07-09 22:18',
    contact: 'Layla Hassan',
    response: 'responded',
  },
  {
    id: 'EM-1120',
    userId: 'U009',
    name: 'Elena Kozlov',
    type: 'Medical',
    priority: 'medium',
    status: 'resolved',
    duration: '00:09:27',
    started: '2024-07-08 11:03',
    contact: 'Ivan Kozlov',
    response: 'responded',
  },
]

export const priorityLabels = { critical: 'Critical', high: 'High', medium: 'Medium', low: 'Low' }
export const priorityTone = { critical: 'red', high: 'amber', medium: 'blue', low: 'green' }

export const statusLabels = { active: 'Active', resolved: 'Resolved', cancelled: 'Cancelled' }
export const statusTone = { active: 'red', resolved: 'green', cancelled: 'neutral' }

export const responseLabels = { responded: 'Responded', pending: 'Pending' }
export const responseTone = { responded: 'green', pending: 'amber' }

export const responderOptions = [
  'Officer James Park',
  'Officer Maria Lopez',
  'Officer David Kim',
  'Officer Aisha Bello',
]

export const escalationTargets = ['Police Department', 'Fire Department', 'Medical Dispatch', 'Security Team']

export const resolutionTypes = ['Resolved - No Further Action', 'Resolved - Responder Dispatched', 'False Alarm']
