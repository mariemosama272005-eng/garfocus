import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focus_flow/featue/Home/presntation/ui/home_screen.dart';
class HomeHeaderWidget extends StatelessWidget {
  const HomeHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.spa_rounded,
          color: HomeScreen.primaryColor,
          size: 32,
        ),
        8.horizontalSpace,
        Expanded(
          child: Text(
            'FocusFlow',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 23.sp,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).textTheme.titleLarge?.color,
            ),
          ),
        ),
        Icon(
          Icons.notifications_none_rounded,
          color: Theme.of(context).iconTheme.color,
        ),
      ],
    );
  }
}