class HeatmapData {
  const HeatmapData({
    required this.grid,
    required this.weeks,
    required this.startDate,
    required this.endDate,
    required this.totalHabits,
  });

  factory HeatmapData.empty() {
    final now = DateTime.now();
    return HeatmapData(
      grid: const [],
      weeks: 0,
      startDate: now,
      endDate: now,
      totalHabits: 0,
    );
  }

  final List<List<int>> grid;
  final int weeks;
  final DateTime startDate;
  final DateTime endDate;
  final int totalHabits;

  bool get isEmpty => grid.isEmpty || weeks == 0;

  int intensityAt(int row, int col) {
    if (row < 0 || col < 0 || row >= grid.length || col >= weeks) return 0;
    return grid[row][col];
  }

  int get totalActiveDays {
    var count = 0;
    for (final row in grid) {
      for (final level in row) {
        if (level > 0) count++;
      }
    }
    return count;
  }
}
