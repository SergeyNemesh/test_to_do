import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_to_do/app/palette.dart';
import 'package:test_to_do/data/models/task.dart';

class TaskWidget extends StatelessWidget {
  const TaskWidget({
    super.key,
    required this.task,
    required this.onStatusIndexChanged,
    required this.onDelete,
    required this.onTap,
  });

  final Task task;

  final Function(int) onStatusIndexChanged;
  final VoidCallback onDelete;
  final VoidCallback onTap;

  void computerOnPress(int actionIndex) {
    if (actionIndex == 1) {
      onStatusIndexChanged(actionIndex);
      return;
    }
    if (actionIndex == 2) {
      onStatusIndexChanged(actionIndex);
      return;
    }
    if (actionIndex == 3) {
      onStatusIndexChanged(actionIndex);
      return;
    }
    onDelete();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 140.h,
        width: double.infinity,
        padding: EdgeInsets.only(left: 12.w),
        margin: EdgeInsets.symmetric(vertical: 3.h, horizontal: 3.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: blackColor, width: 2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Column(
                  children: [
                    SizedBox(
                      width: 0.7.sw,
                      child: Text(
                        task.taskTitle,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 0.7.sw,
                      child: Text(
                        maxLines: 1,
                        task.taskText,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                ),
                const Spacer(),
                PopupMenuButton(
                  offset: const Offset(-5, 5),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                  ),
                  onSelected: (valueIndex) => computerOnPress(valueIndex),
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 1,
                      child: Text(
                        'ToDo',
                        style: TextStyle(
                          color: Colors.red,
                          decorationColor: Colors.red,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    const PopupMenuItem(
                      value: 2,
                      child: Text(
                        'In Progress',
                        style: TextStyle(
                          color: Colors.orange,
                          decorationColor: Colors.orange,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    const PopupMenuItem(
                      value: 3,
                      child: Text(
                        'Done',
                        style: TextStyle(
                          color: Colors.green,
                          decorationColor: Colors.green,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    const PopupMenuItem(
                      value: 4,
                      child: Text('Delete'),
                    ),
                  ],
                ),
              ],
            ),
            _TaskStatus(task: task),
            const Spacer(),
            _TaskData(createdAt: task.getTaskDate()),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

class _TaskStatus extends StatelessWidget {
  const _TaskStatus({required this.task});

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w),
      height: 22.h,
      decoration: BoxDecoration(
        color: task.getTaskColor(),
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: blackColor),
      ),
      child: Text(task.getTaskTitle()),
    );
  }
}

class _TaskData extends StatelessWidget {
  const _TaskData({required this.createdAt});

  final String createdAt;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.calendar_month,
          size: 24.r,
        ),
        Text(createdAt),
      ],
    );
  }
}
