import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_to_do/data/models/task.dart';
import 'package:test_to_do/data/repositories/task_repository.dart';
import 'package:test_to_do/presentation/autorized/task/bloc/task_cubit.dart';
import 'package:test_to_do/presentation/autorized/task/bloc/task_state.dart';
import 'package:test_to_do/widgets/loading_button.dart';
import 'package:test_to_do/widgets/notification_dialogs.dart';
import 'package:test_to_do/widgets/task_input.dart';
import 'package:toggle_switch/toggle_switch.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key, this.task});

  final Task? task;

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  late final TaskBloc _newTaskBloc;

  @override
  void initState() {
    super.initState();
    _newTaskBloc = TaskBloc(RepositoryProvider.of<TaskRepository>(context), widget.task);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskBloc, TaskState>(
      bloc: _newTaskBloc,
      listener: (context, state) async {
        if (state.isSuccess) {
          await showNotificationDialog(context, 'Success!', '');
          Navigator.of(context).pop(true);
        }
        if (state.error != null) {
          await showNotificationDialog(context, 'Oops!', 'Something went wrong!\nTry again!');
          _newTaskBloc.clearErrors();
        }
        if (state.emptyTask != null) {
          await showNotificationDialog(context, 'No data for Task', 'Add at least title or text');
          _newTaskBloc.clearErrors();
        }
      },
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          title: Text(
            widget.task != null ? 'Edit Task' : 'New Task',
            style: TextStyle(
              fontSize: 28.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(12.r),
          child: Column(
            children: [
              ToggleSwitch(
                minWidth: double.infinity,
                minHeight: 50.h,
                initialLabelIndex: state.getStatusEnumIndex(),
                cornerRadius: 20,
                totalSwitches: 3,
                labels: const [
                  'To Do',
                  'In Progress',
                  'Done',
                ],
                activeBgColors: [
                  [Colors.red[700]!, Colors.red, Colors.red[400]!],
                  [Colors.yellow, Colors.yellow[600]!, Colors.yellow[700]!, Colors.yellow[600]!, Colors.yellow],
                  [Colors.green[400]!, Colors.green, Colors.green[700]!],
                ],
                inactiveBgColor: Colors.white,
                borderColor: [Colors.red[700]!, Colors.red, Colors.yellow, Colors.green, Colors.green[700]!],
                borderWidth: 2,
                dividerColor: Colors.grey,
                animate: true,
                curve: Curves.easeIn,
                animationDuration: 500,
                onToggle: (index) => _newTaskBloc.onStatusChanged(index ?? 0),
              ),
              SizedBox(height: 6.h),
              TaskInput(
                initialValue: state.taskTitle,
                onChange: (title) => _newTaskBloc.onTitleChanged(title),
              ),
              SizedBox(height: 6.h),
              Expanded(
                child: TaskInput(
                  isTitle: false,
                  initialValue: state.taskText,
                  onChange: (text) => _newTaskBloc.onTextChanged(text),
                ),
              ),
              SizedBox(height: 6.h),
              LoadingButton(
                title: widget.task == null ? 'Add task' : 'Update task',
                isLoading: state.isLoading,
                onTap: () => _newTaskBloc.computeTask(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
