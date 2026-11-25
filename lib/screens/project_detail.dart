import 'package:flutter/material.dart';
import 'package:portfolio_mobile/models/project.dart';

class ProjectDetailScreen extends StatelessWidget {
  const ProjectDetailScreen({super.key, required this.project});

  final Project project;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(project.title),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(project.title, style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 16),
          Text(project.description),
          if (project.techStack.isNotEmpty) ...[
            const SizedBox(height: 16),
            Text(
              'Technologies',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 4),
            Text(project.techStack),
          ],
          if (project.projectUrl.isNotEmpty) ...[
            const SizedBox(height: 16),
            Text('Project URL', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 4),
            Text(project.projectUrl),
          ],
        ],
      ),
    );
  }
}
