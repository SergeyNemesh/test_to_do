import 'package:equatable/equatable.dart';
import 'package:test_to_do/data/models/task.dart';

class TaskState extends Equatable {
  const TaskState({
    this.taskTitle = '',
    this.taskText = '',
    this.taskStatus = TaskStatus.toDo,
    this.createAt,
    this.isSuccess = false,
    this.emptyTask,
    this.error,
    this.isLoading = false,
  });

  final String taskTitle;
  final String taskText;
  final TaskStatus taskStatus;
  final DateTime? createAt;
  final bool isSuccess;
  final dynamic emptyTask;
  final dynamic error;
  final bool isLoading;

  TaskState copyWith({
    String? taskTitle,
    String? taskText,
    TaskStatus? taskStatus,
    DateTime? createAt,
    bool? isSuccess,
    dynamic emptyTask,
    dynamic error,
    bool? isLoading,
  }) {
    return TaskState(
      taskTitle: taskTitle ?? this.taskTitle,
      taskText: taskText ?? this.taskText,
      taskStatus: taskStatus ?? this.taskStatus,
      createAt: createAt ?? this.createAt,
      isSuccess: isSuccess ?? this.isSuccess,
      emptyTask: emptyTask,
      error: error,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  int getStatusEnumIndex() {
    if (taskStatus == TaskStatus.toDo) {
      return 0;
    }
    if (taskStatus == TaskStatus.inProgress) {
      return 1;
    }
    return 2;
  }

  @override
  List<Object?> get props => [
        taskTitle,
        taskText,
        taskStatus,
        createAt,
        isSuccess,
        emptyTask,
        error,
        isLoading,
      ];
}
