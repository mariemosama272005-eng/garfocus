import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focus_flow/core/shared_wedgits/appBar_wedgit.dart';
import 'package:focus_flow/core/themes/app_colors.dart';
import 'package:focus_flow/core/themes/app_textStyle.dart';
import 'package:focus_flow/featue/addTasks/presntation/ui/widgets/aiStep_widget.dart';
import 'package:focus_flow/gen/assets.gen.dart';

class AiCreatingPlanScreen extends StatelessWidget {
  const AiCreatingPlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
             AppbarWedgit(),
             35.verticalSpace,

              // AI Image
              Container(
                width: 175.w,
                height: 150.h,
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(35.r),
                ),
                child: Center(
                  child:Assets.images.repot.image(),
              ),
              ),


              
          28.verticalSpace,

              // Title
              Text(
                'AI is creating your plan ...',
                textAlign: TextAlign.center,
                style: AppTextstyle.h2(context),
              ),

            18.verticalSpace,

              // Description
              Text(
                'Analyzing your task, finding the best\n'
                'category, urgency and organizing it\n'
                'into your schedule.',
                textAlign: TextAlign.center,
                style: AppTextstyle.hintTextStyle(context)
                ),
              

              35.verticalSpace,

              // Steps Container
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: 18.w,
                  vertical: 16.h,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.outline,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color:Theme.of(context).colorScheme.outline,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.03),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: const [
                    AiStep(
                      text: 'Understanding your task',
                    ),
                    AiStep(
                      text: 'Choosing the right category',
                    ),
                    AiStep(
                      text: 'Setting the best time',
                    ),
                    AiStep(
                      text: 'Creating your plan',
                    ),
                  ],
                ),
              ),

              const Spacer(),

              // Loading indicator
              SizedBox(
                width: 25.w,
                height: 25.w,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),

              SizedBox(height: 25.h),
            ],
          ),
        ),
      ),
    );
  }
}