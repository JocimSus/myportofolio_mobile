import 'package:json_annotation/json_annotation.dart';

part 'project.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Project {
  const Project({
    required this.title,
    required this.description,
    required this.techStack,
    required this.projectUrl,
    this.projectImageUrl = '',
    this.id,
  });

  factory Project.fromJson(Map<String, dynamic> json) =>
      _$ProjectFromJson(json);

  @JsonKey(includeToJson: false)
  final String? id;
  final String title;
  @JsonKey(defaultValue: '')
  final String description;
  @JsonKey(
    name: 'technologies',
    defaultValue: '',
    fromJson: _technologiesFromJson,
    toJson: _technologiesToJson,
  )
  final String techStack;
  @JsonKey(name: 'project_url', defaultValue: '')
  final String projectUrl;
  @JsonKey(name: 'thumbnail', defaultValue: '')
  final String projectImageUrl;

  Map<String, dynamic> toJson() => _$ProjectToJson(this);

  static final List<Project> items = [];

  static String _technologiesFromJson(Object? value) {
    if (value is List) {
      return value.map((item) => item.toString()).join(', ');
    }
    return value?.toString() ?? '';
  }

  static Object _technologiesToJson(String value) {
    final technologies = value
        .split(',')
        .map((item) => item.trim())
        .where((item) => item.isNotEmpty)
        .toList();
    return technologies;
  }
}
