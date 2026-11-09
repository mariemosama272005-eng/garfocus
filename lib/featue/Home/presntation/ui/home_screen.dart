import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focus_flow/featue/Home/presntation/cubit/cubit/gamification_cubit.dart';
import 'package:focus_flow/featue/Home/presntation/ui/gamification_widget.dart';
import 'package:focus_flow/featue/Home/presntation/ui/highPirority_widget.dart';
import 'package:focus_flow/featue/Home/presntation/ui/todayPrograss_widget.dart';
import 'package:focus_flow/featue/Home/presntation/ui/wedgit/homeHeader_widget.dart';
import 'package:focus_flow/featue/tasks/presentation/cubit/cubit/task_cubit_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const Color primaryColor = Color(0xFF7653D6);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: primaryColor,
      onRefresh: () async {
        context.read<GamificationCubit>().loadData();
        context.read<TaskCubitCubit>().getTasks();
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HomeHeaderWidget(),
            20.verticalSpace,
            const GamificationSectionWidget(),
            20.verticalSpace,
            const TodayProgressWidget(),
            20.verticalSpace,
            const HighPriorityTasksWidget(),
            30.verticalSpace,
          ],
        ),
      ),
    );
  }
}
