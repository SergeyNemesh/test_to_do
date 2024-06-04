import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_to_do/data/models/task.dart';
import 'package:test_to_do/data/repositories/task_repository.dart';
import 'package:test_to_do/presentation/autorized/home/bloc/home_state.dart';

class HomeBloc extends Cubit<HomeState> {
  HomeBloc(this._taskRepository) : super(const HomeState());

  final TaskRepository _taskRepository;

  Future<void> fetchTasks() async {
    emit(state.copyWith(isLoading: true));
    await Future.delayed(const Duration(seconds: 1));
    final result = await _taskRepository.getTasks();
    result.fold(
      (error) => emit(state.copyWith(
        error: error,
        isLoading: false,
      )),
      (tasks) => emit(state.copyWith(
        tasks: tasks,
        isLoading: false,
      )),
    );
  }

  Future<void> deleteTask(int index) async {
    emit(state.copyWith(isLoading: true));
    final tasks = [...state.tasks]..removeAt(index);
    await _taskRepository.updateTasksList(currentTasks: tasks);
    emit(state.copyWith(tasks: tasks, isLoading: false));
  }

  void swapItems(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final tasks = [...state.tasks];
    final item = tasks.removeAt(oldIndex);
    tasks.insert(newIndex, item);
    emit(state.copyWith(tasks: tasks));
  }

  Future<void> onStatusChanged(int statusIndex, Task task) async {
    TaskStatus status = TaskStatus.toDo;
    if (statusIndex == 1) {
      status = TaskStatus.toDo;
    }
    if (statusIndex == 2) {
      status = TaskStatus.inProgress;
    }
    if (statusIndex == 3) {
      status = TaskStatus.done;
    }
    final updatedTask = task.copyWith(taskStatus: status);
    final tasks = [...state.tasks];
    int index = tasks.indexOf(task);
    tasks.remove(task);
    tasks.insert(index, updatedTask);
    await _taskRepository.updateTasksList(currentTasks: tasks);
    emit(state.copyWith(tasks: tasks));
  }

  void sortTasksByStatus(TaskStatus status) {
    final tasks = [...state.tasks];
    final sortedTasks = tasks.where((element) => element.taskStatus == status);
    final otherTasks = tasks.where((element) => element.taskStatus != status);
    final sortedList = [...sortedTasks, ...otherTasks];
    emit(state.copyWith(tasks: sortedList));
  }

  Future<void> removeAllTasks() async {
    await _taskRepository.deleteAllTasks();
  }
}
