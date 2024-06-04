import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_to_do/data/models/task.dart';
import 'package:test_to_do/data/repositories/task_repository.dart';
import 'package:test_to_do/presentation/autorized/task/bloc/task_state.dart';
import 'package:uuid/uuid.dart';

class TaskBloc extends Cubit<TaskState> {
  TaskBloc(
    this.taskRepository,
    this.currentTask,
  ) : super(const TaskState()) {
    if (currentTask != null) {
      setTask();
    }
  }

  final TaskRepository taskRepository;
  final Task? currentTask;

  void setTask() {
    final newState = TaskState(
      taskTitle: currentTask!.taskTitle,
      taskText: currentTask!.taskText,
      taskStatus: currentTask!.taskStatus,
    );
    emit(newState);
  }

  Future<void> computeTask() async {
    emit(state.copyWith(isLoading: true));

    if (state.taskTitle == '' && state.taskText == '') {
      emit(state.copyWith(emptyTask: true, isLoading: false));
      return;
    }

    final task = Task(
      id: currentTask != null ? currentTask!.id : const Uuid().toString(),
      taskTitle: state.taskTitle,
      taskText: state.taskText,
      taskStatus: state.taskStatus,
      createAt: DateTime.now(),
    );

    final result = currentTask != null ? await taskRepository.updateTask(task) : await taskRepository.addNewTask(task);

    if (result) {
      emit(state.copyWith(isSuccess: true, isLoading: false));
    }
    if (!result) {
      emit(state.copyWith(error: true, isLoading: false));
    }
  }

  void onTitleChanged(String title) => emit(state.copyWith(taskTitle: title));

  void onTextChanged(String text) => emit(state.copyWith(taskText: text));

  void onStatusChanged(int index) {
    if (index == 0) {
      emit(state.copyWith(taskStatus: TaskStatus.toDo));
    }
    if (index == 1) {
      emit(state.copyWith(taskStatus: TaskStatus.inProgress));
    }
    if (index == 2) {
      emit(state.copyWith(taskStatus: TaskStatus.done));
    }
  }

  void clearErrors() => emit(state.copyWith());
}
