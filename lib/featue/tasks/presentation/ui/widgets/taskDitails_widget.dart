
import 'package:flutter/material.dart';

class TaskDetailsWidget extends StatelessWidget {
  final String details;
  final bool isCompleted;

  const TaskDetailsWidget({
    super.key,
    required this.details,
    required this.isCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      details,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
            decoration: isCompleted ? TextDecoration.lineThrough : null,
          ),
    );
  }
}
