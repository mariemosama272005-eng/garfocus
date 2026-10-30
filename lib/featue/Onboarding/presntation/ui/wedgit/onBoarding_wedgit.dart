import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:focus_flow/core/themes/app_colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingWedgit extends StatelessWidget {
  final PageController pageController;
  final List<Map<String, dynamic>> onboardingData;
  final int currentIndex;
  final Function(int) onPageChanged;

  const OnBoardingWedgit({
    super.key,
    required this.pageController,
    required this.onboardingData,
    required this.currentIndex,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PageView.builder(
            controller: pageController,
            itemCount: onboardingData.length,
            onPageChanged: onPageChanged,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 31,
                ),
                child: onboardingData[index]['image'].image(
                  fit: BoxFit.contain,
                ),
              );
            },
          ),
        ),

        22.verticalSpace,

        AnimatedSmoothIndicator(
          activeIndex: currentIndex,
          count: onboardingData.length,
          effect: const ExpandingDotsEffect(
            activeDotColor: AppColors.mainColor,
            dotHeight: 8,
            dotWidth: 8,
            spacing: 4,
            dotColor: AppColors.hintColor,
          ),
        ),
      ],
    );
  }
}