import 'dart:ui';

import 'package:frontend/core/widget/app_color.dart';

class TaskModel {
  final String id;
  final String uid;
  final String title;
  final String description;
  final String createdAt;
  final String updatedAt;
  final String dueAt;
  final Color color;

  //<editor-fold desc="Data Methods">
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
          dueAt == other.dueAt&&color==other.color);

  @override
  int get hashCode =>
      id.hashCode ^
      uid.hashCode ^
      title.hashCode ^
      description.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode ^
      dueAt.hashCode^
      color.hashCode    ;

  @override
  String toString() {
    return 'TaskModel{' +
        ' id: $id,' +
        ' uid: $uid,' +
        ' title: $title,' +
        ' description: $description,' +
        ' createdAt: $createdAt,' +
        ' updatedAt: $updatedAt,' +
        ' dueAt: $dueAt,' +
        'color:$color,'+
        '}';
  }

  TaskModel copyWith({
    String? id,
    String? uid,
    String? title,
    String? description,
    String? createdAt,
    String? updatedAt,
    String? dueAt,
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
      color: color?? this.color
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'uid': this.uid,
      'title': this.title,
      'description': this.description,
      'createdAt': this.createdAt,
      'updatedAt': this.updatedAt,
      'dueAt': this.dueAt,
      'color':rgnToHex(color),
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'] ??  " ",
      uid: map['uid'] ??  " ",
      title: map['title'] ??  " ",
      description: map['description'] ??  " ",
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'] ,
      dueAt: map['dueAt'] ,
      color: hexToRgb(map['hexColor']),
    );
  }

  //</editor-fold>
}
