import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_to_do/app/palette.dart';
import 'package:test_to_do/data/repositories/task_repository.dart';
import 'package:test_to_do/presentation/auth_bloc/auth_bloc.dart';
import 'package:test_to_do/presentation/autorized/home/bloc/home_bloc.dart';
import 'package:test_to_do/presentation/autorized/home/bloc/home_state.dart';
import 'package:test_to_do/presentation/autorized/task/task_page.dart';
import 'package:test_to_do/widgets/notification_dialogs.dart';
import 'package:test_to_do/widgets/task_sorter.dart';
import 'package:test_to_do/widgets/task_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeBloc _homeBloc;

  @override
  void initState() {
    super.initState();
    _homeBloc = HomeBloc(RepositoryProvider.of<TaskRepository>(context));
    _homeBloc.fetchTasks();
  }

  Future<void> onExitPress() async {
    final popResult = await showExitDialog(context);
    if (popResult) {
      await _homeBloc.removeAllTasks();
      await context.read<AuthBloc>().deleteUser();
    }
  }

  @override
  Widget build(BuildContext context) => BlocConsumer<HomeBloc, HomeState>(
        bloc: _homeBloc,
        listener: (context, state) async {
          if (state.error != null) {
            await showNotificationDialog(context, 'Oops!', 'Something went wrong!\nTry again.');
            _homeBloc.fetchTasks();
          }
        },
        builder: (context, state) => Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                _Header(onTap: onExitPress),
                SizedBox(height: 6.h),
                TaskSorter(
                  tasks: state.tasks,
                  onStatusSortChanged: (status) => _homeBloc.sortTasksByStatus(status),
                ),
                SizedBox(height: 4.h),
                Expanded(
                  child: Stack(
                    children: [
                      ReorderableListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        shrinkWrap: true,
                        proxyDecorator: (child, index, animation) => Material(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(12),
                          child: child,
                        ),
                        itemBuilder: (context, index) {
                          final task = state.tasks[index];
                          return TaskWidget(
                            key: Key(task.createAt.toString()),
                            task: task,
                            onStatusIndexChanged: (statusIndex) => _homeBloc.onStatusChanged(statusIndex, task),
                            onDelete: () => _homeBloc.deleteTask(index),
                            onTap: () async {
                              final result = await Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) => TaskPage(task: task)));
                              if (result != null) {
                                _homeBloc.fetchTasks();
                              }
                            },
                          );
                        },
                        itemCount: state.tasks.length,
                        onReorder: (oldIndex, newIndex) => _homeBloc.swapItems(oldIndex, newIndex),
                      ),
                      if (state.isLoading) const Center(child: CircularProgressIndicator()),
                      if (state.tasks.isEmpty && !state.isLoading) const Center(child: Text('Add your first Task!')),
                    ],
                  ),
                ),
                SizedBox(height: 6.h),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () async {
              final result =
                  await Navigator.of(context).push(MaterialPageRoute(builder: (context) => const TaskPage()));
              if (result != null) {
                _homeBloc.fetchTasks();
              }
            },
          ),
        ),
      );
}

class _Header extends StatelessWidget {
  const _Header({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              border: Border.all(color: blackColor),
            ),
            child: IconButton(
              onPressed: onTap,
              icon: const Icon(Icons.call_missed),
            ),
          ),
          SizedBox(width: 12.w),
          Text(
            'Task list',
            style: TextStyle(
              fontSize: 28.sp,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }
}
