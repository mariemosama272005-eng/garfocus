import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focus_flow/featue/Home/presntation/ui/gamification_widget.dart';
import 'package:focus_flow/featue/Home/presntation/ui/highPirority_widget.dart';
import 'package:focus_flow/featue/Home/presntation/ui/todayPrograss_widget.dart';
import 'package:focus_flow/featue/Home/presntation/ui/wedgit/homeHeader_widget.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const Color primaryColor = Color(0xFF7653D6);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HomeHeaderWidget(),
          25.verticalSpace,
          const GamificationSectionWidget(),
          22.verticalSpace,
          const TodayProgressWidget(),
          22.verticalSpace,
          const HighPriorityTasksWidget(),
        ],
      ),
    );
  }
}







