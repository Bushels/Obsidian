export function LoadingMap() {
  return (
    <div className="relative flex h-full w-full items-center justify-center bg-gray-900">
      {/* Shimmer skeleton rectangles */}
      <div className="absolute inset-0 overflow-hidden">
        <div className="skeleton-shimmer absolute left-[10%] top-[20%] h-3 w-[35%] rounded" />
        <div className="skeleton-shimmer absolute left-[55%] top-[15%] h-4 w-[25%] rounded" />
        <div className="skeleton-shimmer absolute left-[5%] top-[40%] h-3 w-[20%] rounded" />
        <div className="skeleton-shimmer absolute left-[30%] top-[45%] h-4 w-[40%] rounded" />
        <div className="skeleton-shimmer absolute left-[15%] top-[65%] h-3 w-[30%] rounded" />
        <div className="skeleton-shimmer absolute left-[60%] top-[60%] h-3 w-[25%] rounded" />
        <div className="skeleton-shimmer absolute left-[10%] top-[80%] h-4 w-[45%] rounded" />
        <div className="skeleton-shimmer absolute left-[65%] top-[78%] h-3 w-[20%] rounded" />
      </div>

      {/* Centered label */}
      <div className="relative z-10 flex flex-col items-center gap-3">
        <div className="skeleton-shimmer h-10 w-10 rounded-full" />
        <span className="text-sm font-medium text-gray-400">
          Loading well data...
        </span>
      </div>
    </div>
  );
}
