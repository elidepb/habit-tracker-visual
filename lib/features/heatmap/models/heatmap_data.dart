class HeatmapData {
  const HeatmapData({
    required this.grid,
    required this.weeks,
    required this.startDate,
    required this.endDate,
    required this.totalHabits,
    required this.totalActiveDays,
  });

  factory HeatmapData.empty() {
    final now = DateTime.now();
    return HeatmapData(
      grid: const [],
      weeks: 0,
      startDate: now,
      endDate: now,
      totalHabits: 0,
      totalActiveDays: 0,
    );
  }

  final List<List<int>> grid;
  final int weeks;
  final DateTime startDate;
  final DateTime endDate;
  final int totalHabits;
  final int totalActiveDays;

  bool get isEmpty => grid.isEmpty || weeks == 0;

  int intensityAt(int row, int col) {
    if (row < 0 || col < 0 || row >= grid.length || col >= weeks) return 0;
    return grid[row][col];
  }
}
