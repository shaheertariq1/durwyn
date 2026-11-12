import { Bar, BarChart, CartesianGrid, ResponsiveContainer, Tooltip, XAxis, YAxis } from 'recharts'
import {
  CHART_AXIS_STYLE,
  CHART_GRID_COLOR,
  CHART_GRID_DASH,
  tooltipContentStyle,
  tooltipItemStyle,
  tooltipLabelStyle,
} from './chartTheme.js'
import './EmergencyStatisticsChart.css'

function EmergencyStatisticsChart({ data, categories }) {
  return (
    <div className="emergency-chart">
      <ResponsiveContainer width="100%" height={153}>
        <BarChart data={data} margin={{ top: 4, right: 4, bottom: 0, left: 0 }}>
          <CartesianGrid stroke={CHART_GRID_COLOR} strokeDasharray={CHART_GRID_DASH} />
          <XAxis dataKey="month" tick={CHART_AXIS_STYLE} axisLine={false} tickLine={false} />
          <YAxis
            domain={[0, 80]}
            ticks={[0, 20, 40, 60, 80]}
            tick={CHART_AXIS_STYLE}
            axisLine={false}
            tickLine={false}
            width={30}
          />
          <Tooltip
            contentStyle={tooltipContentStyle}
            labelStyle={tooltipLabelStyle}
            itemStyle={tooltipItemStyle}
          />
          <Bar
            dataKey={(entry) => categories.reduce((sum, category) => sum + entry[category.key], 0)}
            name="Emergencies"
            fill="#8b5cf6"
            radius={[4, 4, 0, 0]}
            maxBarSize={55}
            isAnimationActive={false}
          />
        </BarChart>
      </ResponsiveContainer>

      <ul className="emergency-chart__legend">
        {categories.map((category) => (
          <li key={category.key} className="emergency-chart__legend-item">
            <span
              className="emergency-chart__legend-dot"
              style={{ background: category.color }}
              aria-hidden="true"
            />
            <span style={{ color: category.color }}>{category.label}</span>
          </li>
        ))}
      </ul>
    </div>
  )
}

export default EmergencyStatisticsChart
