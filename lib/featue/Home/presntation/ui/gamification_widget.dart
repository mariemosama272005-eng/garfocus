import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focus_flow/featue/Home/data/models/gamification_model.dart';
import 'package:focus_flow/featue/Home/presntation/cubit/cubit/gamification_cubit.dart';
import 'package:focus_flow/featue/Home/presntation/ui/levelCard_widget.dart';
import 'package:focus_flow/featue/Home/presntation/ui/streakCard_widget.dart';
import 'package:focus_flow/featue/Home/presntation/ui/wedgit/dolphineChar_widget.dart';

class GamificationSectionWidget extends StatelessWidget {
  const GamificationSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GamificationCubit, GamificationModel>(
      builder: (context, data) {
        return Column(
          children: [
            DolphinCharacterWidget(level: data.level),
            15.verticalSpace,
            LevelCardWidget(
              level: data.level,
              currentXp: data.currentLevelXp,
              progress: data.progress,
              totalXp: data.xp,
            ),
            15.verticalSpace,
            StreakCardWidget(streak: data.streak),
          ],
        );
      },
    );
  }
}
