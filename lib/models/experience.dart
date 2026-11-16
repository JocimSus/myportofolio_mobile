class Experience {
  final String title;
  final String description;
  final String category;
  final String thumbnailUrl;
  final DateTime startDate;
  final DateTime? endDate; // null berarti masih berlangsung

  Experience({
    required this.title,
    required this.description,
    required this.category,
    required this.thumbnailUrl,
    required this.startDate,
    this.endDate,
  });

  // Penyimpanan sementara di memori untuk semua pengalaman yang ditambahkan
  // lewat formulir. Data hilang saat aplikasi dimulai ulang.
  static final List<Experience> items = [];

  bool get isOngoing => endDate == null;

  static String formatDate(DateTime date) {
    final String month = date.month.toString().padLeft(2, '0');
    final String day = date.day.toString().padLeft(2, '0');
    return "${date.year}-$month-$day";
  }

  String get periodLabel {
    final String start = formatDate(startDate);
    return isOngoing
        ? "$start - Sedang berlangsung"
        : "$start - ${formatDate(endDate!)}";
  }
}
