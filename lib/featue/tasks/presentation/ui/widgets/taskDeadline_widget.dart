
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focus_flow/featue/tasks/Data/models/task_model.dart';

class TaskDeadlineWidget extends StatelessWidget {
  final TaskModel task;

  const TaskDeadlineWidget({super.key, required this.task});

  String _getDeadlineText(BuildContext context) {
    if (task.deadlineDate == null) return '';

    final date = '${task.deadlineDate!.day}/'
        '${task.deadlineDate!.month}/'
        '${task.deadlineDate!.year}';

    if (task.deadlineMinutes == null) return date;

    final minutes = task.deadlineMinutes!;
    final time = TimeOfDay(
      hour: minutes ~/ 60,
      minute: minutes % 60,
    );

    return '$date\n${time.format(context)}';
  }

  @override
  Widget build(BuildContext context) {
    final deadlineText = _getDeadlineText(context);
    if (deadlineText.isEmpty) return const SizedBox.shrink();

    return Column(
      children: [
        8.verticalSpace,
        Row(
          children: [
            Icon(
              Icons.access_time,
              size: 15.sp,
              color: Theme.of(context).textTheme.bodySmall?.color,
            ),
            5.horizontalSpace,
            Expanded(
              child: Text(
                deadlineText,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
