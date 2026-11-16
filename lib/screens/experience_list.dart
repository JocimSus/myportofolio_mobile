import 'package:material_ui/material_ui.dart';
import 'package:portfolio_mobile/models/experience.dart';
import 'package:portfolio_mobile/screens/experience_form.dart';
import 'package:portfolio_mobile/widgets/left_drawer.dart';

class ExperienceListPage extends StatelessWidget {
  const ExperienceListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Experience List',
          ),
        ),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: Experience.items.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.work_off_outlined,
                      size: 64, color: Colors.grey),
                  const SizedBox(height: 8),
                  const Text('Belum ada pengalaman yang ditambahkan.'),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ExperienceFormPage(),
                        ),
                      );
                    },
                    child: const Text('Tambah pengalaman pertama'),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: Experience.items.length,
              itemBuilder: (context, index) {
                final Experience experience = Experience.items[index];
                return Card(
                  elevation: 2.0,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                experience.title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                            // Penanda kecil untuk pengalaman yang masih berjalan.
                            if (experience.isOngoing)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Text(
                                  'Berlangsung',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          experience.category,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          experience.periodLabel,
                          style: const TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(height: 8),
                        Text(experience.description),
                        if (experience.thumbnailUrl.trim().isNotEmpty) ...[
                          const SizedBox(height: 4),
                          Text('Thumbnail: ${experience.thumbnailUrl}'),
                        ],
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
