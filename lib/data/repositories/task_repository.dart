import 'dart:convert';
import 'package:dartz/dartz.dart' as dz;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_to_do/common/utils.dart';
import 'package:test_to_do/data/models/task.dart';

const String _taskKey = 'taskKey';

class TaskRepository {
  const TaskRepository({
    required this.sp,
  });

  final SharedPreferences sp;

  Future<bool> addNewTask(Task task) async {
    final isError = await getErrorWithDelay();
    if (isError) {
      return false;
    }
    final taskData = sp.getString(_taskKey);
    if (taskData != null) {
      final tasksDecode = jsonDecode(taskData);
      final tasks = List<Task>.from(tasksDecode.map((model) => Task.fromMap(model)));
      tasks.add(task);
      final jsonTaskList = tasks.map((task) => task.toMap()).toList();
      await sp.setString(_taskKey, jsonEncode(jsonTaskList));
      return true;
    }
    await sp.setString(_taskKey, jsonEncode([task.toMap()]));
    return true;
  }

  Future<bool> updateTask(Task task) async {
    final isError = await getErrorWithDelay();
    if (isError) {
      return false;
    }
    final taskData = sp.getString(_taskKey);
    final tasksDecode = jsonDecode(taskData!);
    final tasks = List<Task>.from(tasksDecode.map((model) => Task.fromMap(model)));
    tasks.removeWhere((element) => element.id == task.id);
    tasks.add(task);
    final jsonTaskList = tasks.map((task) => task.toMap()).toList();
    await sp.setString(_taskKey, jsonEncode(jsonTaskList));
    return true;
  }

  Future<dz.Either<bool, List<Task>>> getTasks() async {
    try {
      final isError = await getErrorWithDelay();
      if (isError) {
        throw Exception('some error');
      }
      final taskData = sp.getString(_taskKey);
      if (taskData == null) {
        return const dz.Right([]);
      }
      final tasksDecode = jsonDecode(taskData);
      final tasks = List<Task>.from(tasksDecode.map((model) => Task.fromMap(model)));
      return dz.Right(tasks);
    } catch (e) {
      return const dz.Left(true);
    }
  }

  Future<void> updateTasksList({required List<Task> currentTasks}) async {
    final jsonTaskList = currentTasks.map((task) => task.toMap()).toList();
    await sp.setString(_taskKey, jsonEncode(jsonTaskList));
  }

  Future<void> deleteAllTasks() async => await sp.remove(_taskKey);
}
