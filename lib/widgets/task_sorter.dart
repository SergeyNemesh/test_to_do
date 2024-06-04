import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_to_do/app/palette.dart';
import 'package:test_to_do/data/models/task.dart';

class TaskSorter extends StatelessWidget {
  const TaskSorter({
    super.key,
    required this.tasks,
    required this.onStatusSortChanged,
  });

  final List<Task> tasks;
  final Function(TaskStatus) onStatusSortChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Row(
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(50),
            onTap: () => onStatusSortChanged(TaskStatus.toDo),
            child: Container(
              padding: EdgeInsets.only(left: 3.w),
              width: 0.22.sw,
              decoration: BoxDecoration(
                border: Border.all(color: blackColor),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Row(
                children: [
                  Text(
                    'To Do',
                    style: TextStyle(fontSize: 15.sp),
                  ),
                  const Spacer(),
                  _countWidget(
                    tasks.where((element) => element.taskStatus == TaskStatus.toDo).length.toInt(),
                    Colors.red[300]!,
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          InkWell(
            borderRadius: BorderRadius.circular(50),
            onTap: () => onStatusSortChanged(TaskStatus.inProgress),
            child: Container(
              width: 0.35.sw,
              padding: EdgeInsets.only(left: 3.w),
              decoration: BoxDecoration(
                border: Border.all(color: blackColor),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Row(
                children: [
                  Text(
                    'In Progress',
                    style: TextStyle(fontSize: 15.sp),
                  ),
                  const Spacer(),
                  _countWidget(
                    tasks.where((element) => element.taskStatus == TaskStatus.inProgress).length.toInt(),
                    Colors.yellow[300]!,
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          InkWell(
            borderRadius: BorderRadius.circular(50),
            onTap: () => onStatusSortChanged(TaskStatus.done),
            child: Container(
              width: 0.22.sw,
              padding: EdgeInsets.only(left: 3.w),
              decoration: BoxDecoration(
                border: Border.all(color: blackColor),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Row(
                children: [
                  Text(
                    'Done',
                    style: TextStyle(fontSize: 15.sp),
                  ),
                  const Spacer(),
                  _countWidget(
                    tasks.where((element) => element.taskStatus == TaskStatus.done).length.toInt(),
                    Colors.green[300]!,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _countWidget(int count, Color color) {
    return Container(
      margin: EdgeInsets.only(right: 1.w, top: 1.h, bottom: 1.h),
      height: 22.r,
      width: 22.r,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color, border: Border.all(color: blackColor)),
      child: Text(
        count.toString(),
        textAlign: TextAlign.center,
      ),
    );
  }
}
