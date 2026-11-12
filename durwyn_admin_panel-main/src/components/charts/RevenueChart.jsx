import { Bar, BarChart, CartesianGrid, ResponsiveContainer, Tooltip, XAxis, YAxis } from 'recharts'
import {
  CHART_AXIS_STYLE,
  CHART_GRID_COLOR,
  CHART_GRID_DASH,
  tooltipContentStyle,
  tooltipItemStyle,
  tooltipLabelStyle,
} from './chartTheme.js'

function formatThousands(value) {
  return `$${Math.round(value / 1000)}k`
}

function RevenueChart({ data }) {
  return (
    <ResponsiveContainer width="100%" height={180}>
      <BarChart data={data} margin={{ top: 4, right: 4, bottom: 0, left: 0 }}>
        <CartesianGrid stroke={CHART_GRID_COLOR} strokeDasharray={CHART_GRID_DASH} />
        <XAxis dataKey="month" tick={CHART_AXIS_STYLE} axisLine={false} tickLine={false} />
        <YAxis
          tick={CHART_AXIS_STYLE}
          axisLine={false}
          tickLine={false}
          width={50}
          tickFormatter={formatThousands}
        />
        <Tooltip
          contentStyle={tooltipContentStyle}
          labelStyle={tooltipLabelStyle}
          itemStyle={tooltipItemStyle}
          formatter={(value) => [`$${value.toLocaleString()}`, 'Revenue']}
        />
        <Bar
          dataKey="revenue"
          fill="#22c55e"
          radius={[4, 4, 0, 0]}
          maxBarSize={55}
          isAnimationActive={false}
        />
      </BarChart>
    </ResponsiveContainer>
  )
}

export default RevenueChart
