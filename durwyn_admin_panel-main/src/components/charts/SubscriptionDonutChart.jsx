import { Cell, Pie, PieChart, Tooltip } from 'recharts'
import { tooltipContentStyle, tooltipItemStyle } from './chartTheme.js'
import './SubscriptionDonutChart.css'

function SubscriptionDonutChart({ segments }) {
  return (
    <div className="subscription-donut">
      <div className="subscription-donut__chart">
        <PieChart width={160} height={160}>
          <Pie
            data={segments}
            dataKey="value"
            nameKey="label"
            cx="50%"
            cy="50%"
            innerRadius={50}
            outerRadius={80}
            paddingAngle={2}
            stroke="none"
            isAnimationActive={false}
          >
            {segments.map((segment) => (
              <Cell key={segment.key} fill={segment.color} />
            ))}
          </Pie>
          <Tooltip
            contentStyle={tooltipContentStyle}
            itemStyle={tooltipItemStyle}
            formatter={(value, name) => [value.toLocaleString(), name]}
          />
        </PieChart>
      </div>

      <ul className="subscription-donut__legend">
        {segments.map((segment) => (
          <li key={segment.key} className="subscription-donut__legend-item">
            <span className="subscription-donut__legend-label">
              <span
                className="subscription-donut__legend-dot"
                style={{ background: segment.color }}
                aria-hidden="true"
              />
              {segment.label}
            </span>
            <span className="subscription-donut__legend-value">
              <strong>{segment.value.toLocaleString()}</strong> ({segment.percent}%)
            </span>
          </li>
        ))}
      </ul>
    </div>
  )
}

export default SubscriptionDonutChart
