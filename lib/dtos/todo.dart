import 'dart:convert';

class Todo {
  String id;
  String createdBy;
  String title;
  String description;
  DateTime startDate;
  DateTime endDate;
  Labels labels;

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
        labels: Labels.fromJson(json["labels"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_by": createdBy,
        "title": title,
        "description": description,
        "start_date": startDate.toIso8601String(),
        "end_date": endDate.toIso8601String(),
        "labels": labels.toJson(),
      };
}

class Labels {
  bool codear;
  bool comer;
  bool flojear;
  bool comprar;

  Labels({
    required this.codear,
    required this.comer,
    required this.flojear,
    required this.comprar,
  });

  factory Labels.fromRawJson(String str) => Labels.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Labels.fromJson(Map<String, dynamic> json) => Labels(
        codear: json["codear"],
        comer: json["comer"],
        flojear: json["flojear"],
        comprar: json["comprar"],
      );

  Map<String, dynamic> toJson() => {
        "codear": codear,
        "comer": comer,
        "flojear": flojear,
        "comprar": comprar,
      };
}
