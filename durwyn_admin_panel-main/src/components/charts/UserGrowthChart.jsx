import {
  Area,
  AreaChart,
  CartesianGrid,
  ResponsiveContainer,
  Tooltip,
  XAxis,
  YAxis,
} from 'recharts'
import {
  CHART_AXIS_STYLE,
  CHART_GRID_COLOR,
  CHART_GRID_DASH,
  tooltipContentStyle,
  tooltipItemStyle,
  tooltipLabelStyle,
} from './chartTheme.js'

function UserGrowthChart({ data }) {
  return (
    <ResponsiveContainer width="100%" height={180}>
      <AreaChart data={data} margin={{ top: 4, right: 4, bottom: 0, left: 0 }}>
        <defs>
          <linearGradient id="userGrowthFill" x1="0" y1="0" x2="0" y2="1">
            <stop offset="0%" stopColor="#22c55e" stopOpacity={0.35} />
            <stop offset="100%" stopColor="#22c55e" stopOpacity={0} />
          </linearGradient>
        </defs>
        <CartesianGrid stroke={CHART_GRID_COLOR} strokeDasharray={CHART_GRID_DASH} />
        <XAxis dataKey="month" tick={CHART_AXIS_STYLE} axisLine={false} tickLine={false} />
        <YAxis tick={CHART_AXIS_STYLE} axisLine={false} tickLine={false} width={44} />
        <Tooltip
          contentStyle={tooltipContentStyle}
          labelStyle={tooltipLabelStyle}
          itemStyle={tooltipItemStyle}
        />
        <Area
          type="monotone"
          dataKey="users"
          stroke="#22c55e"
          strokeWidth={2}
          fill="url(#userGrowthFill)"
          activeDot={{ r: 4 }}
          isAnimationActive={false}
        />
      </AreaChart>
    </ResponsiveContainer>
  )
}

export default UserGrowthChart
