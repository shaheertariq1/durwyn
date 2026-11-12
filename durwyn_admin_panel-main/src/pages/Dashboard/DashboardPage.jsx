import KpiCard from '../../components/KpiCard/KpiCard.jsx'
import ChartCard from '../../components/ChartCard/ChartCard.jsx'
import UserGrowthChart from '../../components/charts/UserGrowthChart.jsx'
import RevenueChart from '../../components/charts/RevenueChart.jsx'
import EmergencyStatisticsChart from '../../components/charts/EmergencyStatisticsChart.jsx'
import SubscriptionDonutChart from '../../components/charts/SubscriptionDonutChart.jsx'
import RecentActivity from '../../components/RecentActivity/RecentActivity.jsx'
import QuickActions from '../../components/QuickActions/QuickActions.jsx'
import {
  emergencyStatisticsChart,
  kpiCards,
  quickActions,
  recentActivity,
  revenueTrend,
  subscriptionSplit,
  userGrowthTrend,
} from '../../data/mockDashboard.js'
import './DashboardPage.css'

function DashboardPage() {
  return (
    <div className="dashboard-page">
      <div className="dashboard-page__kpi-grid">
        {kpiCards.map((kpi) => (
          <KpiCard key={kpi.id} {...kpi} />
        ))}
      </div>

      <div className="dashboard-page__chart-row">
        <ChartCard
          title={userGrowthTrend.title}
          subtitle={userGrowthTrend.subtitle}
          badge={userGrowthTrend.changeLabel}
        >
          <UserGrowthChart data={userGrowthTrend.data} />
        </ChartCard>

        <ChartCard
          title={revenueTrend.title}
          subtitle={revenueTrend.subtitle}
          badge={revenueTrend.changeLabel}
        >
          <RevenueChart data={revenueTrend.data} />
        </ChartCard>
      </div>

      <div className="dashboard-page__chart-row">
        <ChartCard title={emergencyStatisticsChart.title}>
          <EmergencyStatisticsChart
            data={emergencyStatisticsChart.data}
            categories={emergencyStatisticsChart.categories}
          />
        </ChartCard>

        <ChartCard title={subscriptionSplit.title} subtitle={subscriptionSplit.totalLabel}>
          <SubscriptionDonutChart segments={subscriptionSplit.segments} />
        </ChartCard>
      </div>

      <div className="dashboard-page__bottom-row">
        <RecentActivity items={recentActivity} />
        <QuickActions actions={quickActions} />
      </div>
    </div>
  )
}

export default DashboardPage
