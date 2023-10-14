import 'dart:convert';

class Todo {
  String id = '';
  String createdBy = '';
  String title = '';
  String description = '';
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  List<String> labels = [];

  Todo.empty();

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
        id: json["_id"],
        createdBy: json["createdBy"],
        title: json["title"],
        description: json["description"],
        startDate: DateTime.parse(json["startDate"]),
        endDate: DateTime.parse(json["endDate"]),
        labels: List<String>.from(json["labels"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "createdBy": createdBy,
        "title": title,
        "description": description,
        "startDate": startDate.toIso8601String(),
        "endDate": endDate.toIso8601String(),
        "labels": List<dynamic>.from(labels.map((x) => x)),
      };
}
