import 'package:equatable/equatable.dart';
import 'package:test_to_do/data/models/task.dart';

class HomeState extends Equatable {
  const HomeState({
    this.tasks = const [],
    this.isLoading = false,
    this.error,
  });

  final List<Task> tasks;
  final bool isLoading;
  final dynamic error;

  HomeState copyWith({
    List<Task>? tasks,
    bool? isLoading,
    dynamic error,
  }) {
    return HomeState(
      tasks: tasks ?? this.tasks,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  @override
  List<Object?> get props => [
        tasks,
        isLoading,
        error,
      ];
}
