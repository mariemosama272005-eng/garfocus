import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focus_flow/core/shared_wedgits/appBar_wedgit.dart';
import 'package:focus_flow/core/themes/app_textStyle.dart';
import 'package:focus_flow/featue/addTasks/presntation/ui/widgets/aiStep_widget.dart';
import 'package:focus_flow/featue/addTasks/presntation/ui/widgets/image_widget.dart';
import 'package:focus_flow/featue/addTasks/presntation/ui/widgets/lodingIndicator_widget.dart';
import 'package:focus_flow/featue/addTasks/presntation/ui/widgets/stepCont_widget.dart';
import 'package:focus_flow/featue/addTasks/presntation/ui/widgets/text_widget.dart';
import 'package:focus_flow/gen/assets.gen.dart';

class AiCreatingPlanScreen extends StatelessWidget {
  const AiCreatingPlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              const AppbarWedgit(),
              35.verticalSpace,
              const AiImageWidget(),
              28.verticalSpace,
              const AiInfoTextWidget(),
              35.verticalSpace,
              const AiStepsContainerWidget(),
              const Spacer(),
              const AiLoadingIndicatorWidget(),
              SizedBox(height: 25.h),
            ],
          ),
        ),
      ),
    );
  }
}


