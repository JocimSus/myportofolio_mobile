class Project {
  final String name;
  final String description;
  final String category;
  final String technologies;
  final String link;

  Project({
    required this.name,
    required this.description,
    required this.category,
    required this.technologies,
    required this.link,
  });

  // Penyimpanan sementara di memori untuk semua proyek yang ditambahkan
  // lewat formulir. Data hilang saat aplikasi dimulai ulang.
  static final List<Project> items = [];
}
