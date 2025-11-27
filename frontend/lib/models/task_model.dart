import 'dart:ui';
import 'package:frontend/core/widget/app_color.dart';

class TaskModel {
  final String id;
  final String uid;
  final String title;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime dueAt;
  final Color color;

  const TaskModel({
    required this.id,
    required this.uid,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.dueAt,
    required this.color,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          (other is TaskModel &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              uid == other.uid &&
              title == other.title &&
              description == other.description &&
              createdAt == other.createdAt &&
              updatedAt == other.updatedAt &&
              dueAt == other.dueAt &&
              color == other.color);

  @override
  int get hashCode =>
      id.hashCode ^
      uid.hashCode ^
      title.hashCode ^
      description.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode ^
      dueAt.hashCode ^
      color.hashCode;

  @override
  String toString() {
    return 'TaskModel{'
        ' id: $id,'
        ' uid: $uid,'
        ' title: $title,'
        ' description: $description,'
        ' createdAt: $createdAt,'
        ' updatedAt: $updatedAt,'
        ' dueAt: $dueAt,'
        ' color: $color,'
        '}';
  }

  TaskModel copyWith({
    String? id,
    String? uid,
    String? title,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? dueAt,
    Color? color,
  }) {
    return TaskModel(
      id: id ?? this.id,
      uid: uid ?? this.uid,
      title: title ?? this.title,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      dueAt: dueAt ?? this.dueAt,
      color: color ?? this.color,
    );
  }

  // -------------------------
  //  TO MAP (ISO FORMATTED)
  // -------------------------
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'uid': uid,
      'title': title,
      'description': description,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'dueAt': dueAt.toIso8601String(),
      'hexColor': rgnToHex(color),
    };
  }

  // -------------------------
  //  FROM MAP (PARSE ISO)
  // -------------------------
  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'] ?? "",
      uid: map['uid'] ?? "",
      title: map['title'] ?? "",
      description: map['description'] ?? "",
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
      dueAt: DateTime.parse(map['dueAt']),
      color: hexToRgb(map['hexColor']),
    );
  }
}
