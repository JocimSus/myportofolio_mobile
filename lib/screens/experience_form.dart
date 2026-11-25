import 'package:material_ui/material_ui.dart';
import 'package:portfolio_mobile/models/experience.dart';
import 'package:portfolio_mobile/widgets/left_drawer.dart';

class ExperienceFormPage extends StatefulWidget {
  const ExperienceFormPage({super.key});

  @override
  State<ExperienceFormPage> createState() => _ExperienceFormPageState();
}

class _ExperienceFormPageState extends State<ExperienceFormPage> {
  final _formKey = GlobalKey<FormState>();

  String _title = "";
  String _description = "";
  String _category = "Internship"; // default
  String _thumbnailUrl = "";
  DateTime? _startDate;
  DateTime? _endDate;
  bool _isOngoing = false;

  // Controller agar teks tanggal bisa diisi/dikosongkan secara terprogram
  // setelah pengguna memilih tanggal lewat showDatePicker().
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();

  // Kategori meniru pilihan ExperienceType pada model web portofolio.
  final List<String> _categories = [
    'Internship',
    'Research',
    'Volunteer',
    'Part-Time',
    'Full-Time',
    'Freelance',
    'Competition',
    'Organization',
    'Committee',
    'Community',
  ];

  @override
  void dispose() {
    _startDateController.dispose();
    _endDateController.dispose();
    super.dispose();
  }

  String _formatDate(DateTime date) => Experience.formatDate(date);

  Future<void> _pickDate({required bool isStartDate}) async {
    final DateTime now = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: (isStartDate ? _startDate : _endDate) ?? now,
      firstDate: DateTime(2000),
      lastDate: DateTime(now.year + 5),
    );
    if (picked == null) return;
    setState(() {
      if (isStartDate) {
        _startDate = picked;
        _startDateController.text = _formatDate(picked);
      } else {
        _endDate = picked;
        _endDateController.text = _formatDate(picked);
      }
    });
  }

  void _resetForm() {
    _formKey.currentState!.reset();
    _startDateController.clear();
    _endDateController.clear();
    setState(() {
      _title = "";
      _description = "";
      _category = "Internship";
      _thumbnailUrl = "";
      _startDate = null;
      _endDate = null;
      _isOngoing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Add Experience Form')),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // === Experience Title ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Judul Pengalaman",
                    labelText: "Judul Pengalaman",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _title = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Judul pengalaman tidak boleh kosong!";
                    }
                    if (value.length > 255) {
                      return "Judul pengalaman maksimal 255 karakter!";
                    }
                    return null;
                  },
                ),
              ),
              // === Description ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: "Deskripsi Pengalaman",
                    labelText: "Deskripsi Pengalaman",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _description = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Deskripsi pengalaman tidak boleh kosong!";
                    }
                    return null;
                  },
                ),
              ),
              // === Category ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: "Kategori Pengalaman",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  initialValue: _category,
                  items: _categories
                      .map(
                        (category) => DropdownMenuItem(
                          value: category,
                          child: Text(category),
                        ),
                      )
                      .toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _category = newValue!;
                    });
                  },
                ),
              ),
              // === Thumbnail URL (opsional) ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.url,
                  decoration: InputDecoration(
                    hintText: "https://contoh.com/gambar.png",
                    labelText: "Thumbnail URL (opsional)",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _thumbnailUrl = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return null; // opsional, boleh kosong
                    }
                    final Uri? uri = Uri.tryParse(value.trim());
                    final bool isValidUrl =
                        uri != null &&
                        (uri.isScheme('http') || uri.isScheme('https')) &&
                        uri.host.isNotEmpty;
                    if (!isValidUrl) {
                      return "Masukkan URL valid (diawali http:// atau https://)!";
                    }
                    return null;
                  },
                ),
              ),
              // === Start Date ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _startDateController,
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: "YYYY-MM-DD",
                    labelText: "Tanggal Mulai",
                    suffixIcon: const Icon(Icons.calendar_today),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onTap: () => _pickDate(isStartDate: true),
                  validator: (String? value) {
                    if (_startDate == null) {
                      return "Tanggal mulai tidak boleh kosong!";
                    }
                    return null;
                  },
                ),
              ),
              // === Bonus: saklar "Sedang berlangsung" (meniru is_ongoing) ===
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: SwitchListTile(
                  title: const Text("Sedang berlangsung"),
                  subtitle: const Text(
                    "Aktifkan jika pengalaman ini belum selesai",
                  ),
                  activeThumbColor: Theme.of(context).colorScheme.secondary,
                  value: _isOngoing,
                  onChanged: (bool value) {
                    setState(() {
                      _isOngoing = value;
                      if (value) {
                        // Pengalaman berjalan tidak memiliki tanggal selesai.
                        _endDate = null;
                        _endDateController.clear();
                      }
                    });
                  },
                ),
              ),
              // === End Date ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _endDateController,
                  readOnly: true,
                  enabled: !_isOngoing,
                  decoration: InputDecoration(
                    hintText: "YYYY-MM-DD",
                    labelText: _isOngoing
                        ? "Tanggal Selesai (nonaktif, sedang berlangsung)"
                        : "Tanggal Selesai",
                    suffixIcon: const Icon(Icons.event),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onTap: () => _pickDate(isStartDate: false),
                  validator: (String? value) {
                    if (_isOngoing) {
                      return null; // tidak dipakai saat masih berlangsung
                    }
                    if (_endDate == null) {
                      return "Pilih tanggal selesai atau aktifkan 'Sedang berlangsung'!";
                    }
                    if (_startDate != null && _endDate!.isBefore(_startDate!)) {
                      return "Tanggal selesai tidak boleh sebelum tanggal mulai!";
                    }
                    return null;
                  },
                ),
              ),
              // === Tombol Simpan ===
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.indigo),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Simpan pengalaman ke daftar di memori agar tampil
                        // pada halaman Experience List.
                        Experience.items.add(
                          Experience(
                            title: _title,
                            description: _description,
                            category: _category,
                            thumbnailUrl: _thumbnailUrl.trim(),
                            startDate: _startDate!,
                            endDate: _isOngoing ? null : _endDate,
                          ),
                        );
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text(
                                'Pengalaman berhasil ditambahkan!',
                              ),
                              content: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Judul: $_title'),
                                    Text('Deskripsi: $_description'),
                                    Text('Kategori: $_category'),
                                    Text(
                                      'Thumbnail: ${_thumbnailUrl.trim().isEmpty ? "-" : _thumbnailUrl}',
                                    ),
                                    Text(
                                      'Tanggal Mulai: ${_formatDate(_startDate!)}',
                                    ),
                                    Text(
                                      'Tanggal Selesai: ${_isOngoing ? "Sedang berlangsung" : _formatDate(_endDate!)}',
                                    ),
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                  child: const Text('OK'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    _resetForm();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    child: const Text(
                      "Save",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
