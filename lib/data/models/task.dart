import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum TaskStatus { toDo, inProgress, done }

class Task extends Equatable {
  const Task({
    required this.id,
    required this.taskTitle,
    required this.taskText,
    required this.taskStatus,
    required this.createAt,
  });

  final String id;
  final String taskTitle;
  final String taskText;
  final TaskStatus taskStatus;
  final DateTime createAt;

  @override
  List<Object?> get props => [
        id,
        taskTitle,
        taskText,
        taskStatus,
        createAt,
      ];

  Task copyWith({
    String? taskTitle,
    String? taskText,
    TaskStatus? taskStatus,
    DateTime? createAt,
  }) {
    return Task(
      id: id,
      taskTitle: taskTitle ?? this.taskTitle,
      taskText: taskText ?? this.taskText,
      taskStatus: taskStatus ?? this.taskStatus,
      createAt: createAt ?? this.createAt,
    );
  }

  Color getTaskColor() {
    if (taskStatus == TaskStatus.toDo) {
      return Colors.red;
    }
    if (taskStatus == TaskStatus.inProgress) {
      return Colors.yellow;
    }
    return Colors.green;
  }

  String getTaskTitle() {
    if (taskStatus == TaskStatus.toDo) {
      return 'To Do';
    }
    if (taskStatus == TaskStatus.inProgress) {
      return 'In Progress';
    }
    return 'Done';
  }

  String getTaskDate() {
    final formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(createAt);
    return formattedDate;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'taskTitle': taskTitle,
      'taskText': taskText,
      'taskStatus': taskStatus.toString(),
      'createAt': createAt.toString(),
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['taskTitle'] as String,
      taskTitle: map['taskTitle'] as String,
      taskText: map['taskText'] as String,
      taskStatus: (map['taskStatus'] as String) == 'TaskStatus.toDo'
          ? TaskStatus.toDo
          : (map['taskStatus'] as String) == 'TaskStatus.inProgress'
              ? TaskStatus.inProgress
              : TaskStatus.done,
      createAt: DateTime.parse(map['createAt'] as String),
    );
  }
}
