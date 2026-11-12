// Local mock data standing in for the Emergency Contacts API. Components only
// consume the shapes below, so swapping this module for a real fetch later is a
// drop-in change. `assignedUserId` cross-references src/data/mockUsers.js, and each
// contact's name matches the `contact` field on that user's entry in mockEmergencies.js.

export const contacts = [
  {
    id: 'EC001',
    name: 'Tom Mitchell',
    relationship: 'Spouse',
    assignedUserId: 'U001',
    assignedUserName: 'Sarah Mitchell',
    phone: '+1 555-2001',
    status: 'active',
  },
  {
    id: 'EC002',
    name: 'Maria Rivera',
    relationship: 'Sister',
    assignedUserId: 'U004',
    assignedUserName: 'Daniel Rivera',
    phone: '+1 555-2002',
    status: 'active',
  },
  {
    id: 'EC003',
    name: 'Ama Asante',
    relationship: 'Mother',
    assignedUserId: 'U010',
    assignedUserName: 'Kwame Asante',
    phone: '+1 555-2003',
    status: 'active',
  },
  {
    id: 'EC004',
    name: 'Raj Nair',
    relationship: 'Father',
    assignedUserId: 'U005',
    assignedUserName: 'Priya Nair',
    phone: '+1 555-2004',
    status: 'active',
  },
  {
    id: 'EC005',
    name: 'Hans Fischer',
    relationship: 'Spouse',
    assignedUserId: 'U007',
    assignedUserName: 'Lena Fischer',
    phone: '+1 555-2005',
    status: 'inactive',
  },
  {
    id: 'EC006',
    name: 'Linda Carter',
    relationship: 'Mother',
    assignedUserId: 'U002',
    assignedUserName: 'James Carter',
    phone: '+1 555-2006',
    status: 'active',
  },
  {
    id: 'EC007',
    name: 'Kofi Osei',
    relationship: 'Brother',
    assignedUserId: 'U003',
    assignedUserName: 'Amara Osei',
    phone: '+1 555-2007',
    status: 'active',
  },
  {
    id: 'EC008',
    name: 'Alicia Webb',
    relationship: 'Spouse',
    assignedUserId: 'U006',
    assignedUserName: 'Marcus Webb',
    phone: '+1 555-2008',
    status: 'active',
  },
  {
    id: 'EC009',
    name: 'Layla Hassan',
    relationship: 'Spouse',
    assignedUserId: 'U008',
    assignedUserName: 'Omar Hassan',
    phone: '+1 555-2009',
    status: 'active',
  },
  {
    id: 'EC010',
    name: 'Ivan Kozlov',
    relationship: 'Father',
    assignedUserId: 'U009',
    assignedUserName: 'Elena Kozlov',
    phone: '+1 555-2010',
    status: 'active',
  },
]

export const statusLabels = { active: 'Active', inactive: 'Inactive' }
export const statusTone = { active: 'green', inactive: 'neutral' }
