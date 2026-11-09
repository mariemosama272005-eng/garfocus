
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmptyPriorityCard extends StatelessWidget {
  const EmptyPriorityCard({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(18.r),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF203C32) : const Color(0xFFEAF8F2),
        borderRadius: BorderRadius.circular(18.r),
      ),
      child: Text(
        '🎉 No high priority tasks! You are all caught up.',
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: isDark ? const Color(0xFF9AE0BE) : const Color(0xFF287A57),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
