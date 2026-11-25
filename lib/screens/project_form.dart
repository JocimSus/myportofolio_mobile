import 'package:flutter/material.dart';
import 'package:portfolio_mobile/models/project.dart';
import 'package:portfolio_mobile/services/api_client.dart';
import 'package:portfolio_mobile/services/auth_state.dart';
import 'package:portfolio_mobile/widgets/auth_guard.dart';
import 'package:portfolio_mobile/widgets/left_drawer.dart';
import 'package:provider/provider.dart';

class ProjectFormPage extends StatefulWidget {
  const ProjectFormPage({super.key});

  @override
  State<ProjectFormPage> createState() => _ProjectFormPageState();
}

class _ProjectFormPageState extends State<ProjectFormPage> {
  final _formKey = GlobalKey<FormState>();

  String _title = '';
  String _description = '';
  String _techStack = '';
  String _projectUrl = '';
  String _projectImageUrl = '';
  bool _isSubmitting = false;

  String? _validateUrl(String? value, {required bool optional}) {
    if (value == null || value.trim().isEmpty) {
      return optional ? null : 'URL cannot be empty!';
    }

    final uri = Uri.tryParse(value.trim());
    if (uri == null ||
        !uri.hasScheme ||
        (uri.scheme != 'http' && uri.scheme != 'https')) {
      return 'Enter a valid HTTP or HTTPS URL!';
    }
    return null;
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final authorized = await ensureLoggedIn(context);
    if (!authorized || !mounted) return;

    final authState = context.read<AuthState>();
    final apiClient = context.read<ApiClient>();
    final messenger = ScaffoldMessenger.of(context);
    final token = authState.token;
    if (token == null) return;

    setState(() => _isSubmitting = true);

    final project = Project(
      title: _title.trim(),
      description: _description.trim(),
      techStack: _techStack.trim(),
      projectUrl: _projectUrl.trim(),
      projectImageUrl: _projectImageUrl.trim(),
    );

    try {
      await apiClient.createProject(project, token: token);
      if (!mounted) return;

      await showDialog<void>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: const Text('201 Created'),
          content: const Text('Project was successfully added.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('OK'),
            ),
          ],
        ),
      );

      if (!mounted) return;
      _formKey.currentState?.reset();
      setState(() {
        _title = '';
        _description = '';
        _techStack = '';
        _projectUrl = '';
        _projectImageUrl = '';
      });
    } on ApiException catch (error) {
      if (!mounted) return;

      if (error.statusCode == 401) {
        await authState.logout();
        if (!mounted) return;
        messenger.showSnackBar(
          const SnackBar(content: Text('Session expired. Please login again.')),
        );
        await ensureLoggedIn(context);
      } else {
        messenger.showSnackBar(
          SnackBar(
            content: Text('Failed to create project (${error.statusCode})'),
          ),
        );
      }
    } catch (error) {
      if (!mounted) return;
      messenger.showSnackBar(
        SnackBar(content: Text('Failed to create project: $error')),
      );
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Project'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Title',
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => _title = value,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Title cannot be empty!';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 8),
              TextFormField(
                maxLines: 5,
                decoration: const InputDecoration(
                  hintText: 'Description',
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => _description = value,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Description cannot be empty!';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 8),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Flutter, Django, PostgreSQL',
                  labelText: 'Tech Stack',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => _techStack = value,
              ),
              const SizedBox(height: 8),
              TextFormField(
                keyboardType: TextInputType.url,
                decoration: const InputDecoration(
                  hintText: 'https://example.com/project',
                  labelText: 'Project URL',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => _projectUrl = value,
                validator: (value) => _validateUrl(value, optional: true),
              ),
              const SizedBox(height: 8),
              TextFormField(
                keyboardType: TextInputType.url,
                decoration: const InputDecoration(
                  hintText: 'https://example.com/image.png',
                  labelText: 'Project Image URL (Optional)',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => _projectImageUrl = value,
                validator: (value) => _validateUrl(value, optional: true),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white,
                ),
                onPressed: _isSubmitting ? null : _submit,
                child: _isSubmitting
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

typedef ProjectFormScreen = ProjectFormPage;
