import 'dart:convert';

class Todo {
  final String id;
  final String createdBy;
  final String title;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  final List<String> labels;

  Todo({
    required this.id,
    required this.createdBy,
    required this.title,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.labels,
  });

  factory Todo.fromRawJson(String str) => Todo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
        id: json["id"],
        createdBy: json["created_by"],
        title: json["title"],
        description: json["description"],
        startDate: DateTime.parse(json["start_date"]),
        endDate: DateTime.parse(json["end_date"]),
        labels: List<String>.from(json["labels"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_by": createdBy,
        "title": title,
        "description": description,
        "start_date": startDate.toIso8601String(),
        "end_date": endDate.toIso8601String(),
        "labels": List<dynamic>.from(labels.map((x) => x)),
      };
}
