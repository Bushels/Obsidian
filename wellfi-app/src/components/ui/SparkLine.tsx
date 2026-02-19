interface SparkLineProps {
  data: number[];
  height?: number;
  color?: string;
}

export function SparkLine({ data, height = 40, color = '#00D4FF' }: SparkLineProps) {
  if (data.length === 0) return null;

  const max = Math.max(...data, 1);
  const gap = 1;
  const barWidth = Math.max((100 - gap * (data.length - 1)) / data.length, 1);

  return (
    <svg
      width="100%"
      height={height}
      viewBox={`0 0 ${data.length * (barWidth + gap) - gap} ${height}`}
      preserveAspectRatio="none"
      className="block"
    >
      {data.map((value, i) => {
        const barHeight = value === 0
          ? 2
          : (value / max) * height;

        return (
          <rect
            key={i}
            x={i * (barWidth + gap)}
            y={height - barHeight}
            width={barWidth}
            height={barHeight}
            rx={1}
            fill={value === 0 ? '#374151' : color}
            opacity={value === 0 ? 0.5 : 1}
          />
        );
      })}
    </svg>
  );
}
