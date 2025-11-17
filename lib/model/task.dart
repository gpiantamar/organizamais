import 'package:flutter/material.dart';

class Task {
  final String id;
  final String title;
  final String description;
  final Priority priority;
  final bool isCompleted;
  final bool isHabit;
  final DateTime createdAt;
  final DateTime? completedAt;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.priority,
    this.isCompleted = false,
    this.isHabit = false,
    required this.createdAt,
    this.completedAt,
  });

  Task copyWith({
    String? id,
    String? title,
    String? description,
    Priority? priority,
    bool? isCompleted,
    bool? isHabit,
    DateTime? createdAt,
    DateTime? completedAt,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      priority: priority ?? this.priority,
      isCompleted: isCompleted ?? this.isCompleted,
      isHabit: isHabit ?? this.isHabit,
      createdAt: createdAt ?? this.createdAt,
      completedAt: completedAt ?? this.completedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'priority': priority.toString().split('.').last,
      'isCompleted': isCompleted,
      'isHabit': isHabit,
      'createdAt': createdAt.toIso8601String(),
      'completedAt': completedAt?.toIso8601String(),
    };
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      priority: Priority.values.firstWhere(
        (e) => e.toString().split('.').last == json['priority'],
        orElse: () => Priority.medium,
      ),
      isCompleted: json['isCompleted'] as bool? ?? false,
      isHabit: json['isHabit'] as bool? ?? false,
      createdAt: DateTime.parse(json['createdAt'] as String),
      completedAt: json['completedAt'] != null
          ? DateTime.parse(json['completedAt'] as String)
          : null,
    );
  }
}

enum Priority {
  low,
  medium,
  high,
}

extension PriorityExtension on Priority {
  String get label {
    switch (this) {
      case Priority.low:
        return 'Baixa';
      case Priority.medium:
        return 'Média';
      case Priority.high:
        return 'Alta';
    }
  }

  Color get color {
    switch (this) {
      case Priority.low:
        return Colors.green;
      case Priority.medium:
        return Colors.orange;
      case Priority.high:
        return Colors.red;
    }
  }
}

