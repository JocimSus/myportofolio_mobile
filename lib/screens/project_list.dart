import 'package:material_ui/material_ui.dart';
import 'package:portfolio_mobile/models/project.dart';
import 'package:portfolio_mobile/screens/project_form.dart';
import 'package:portfolio_mobile/widgets/left_drawer.dart';

class ProjectListPage extends StatelessWidget {
  const ProjectListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Project List',
          ),
        ),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: Project.items.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.folder_off_outlined,
                      size: 64, color: Colors.grey),
                  const SizedBox(height: 8),
                  const Text('Belum ada proyek yang ditambahkan.'),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProjectFormPage(),
                        ),
                      );
                    },
                    child: const Text('Tambah proyek pertama'),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: Project.items.length,
              itemBuilder: (context, index) {
                final Project project = Project.items[index];
                return Card(
                  elevation: 2.0,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          project.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          project.category,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(project.description),
                        if (project.technologies.trim().isNotEmpty) ...[
                          const SizedBox(height: 8),
                          Text('Teknologi: ${project.technologies}'),
                        ],
                        if (project.link.trim().isNotEmpty) ...[
                          const SizedBox(height: 4),
                          Text('Tautan: ${project.link}'),
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
