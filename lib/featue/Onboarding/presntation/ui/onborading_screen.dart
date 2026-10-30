import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focus_flow/core/routes/app_routes.dart';

import 'package:focus_flow/core/shared_wedgits/costumButton_wedgit.dart';
import 'package:focus_flow/core/themes/app_textStyle.dart';

import 'package:focus_flow/featue/Onboarding/presntation/cubit/cubit/on_boarding_cubit.dart';
import 'package:focus_flow/featue/Onboarding/presntation/ui/wedgit/onBoarding_wedgit.dart';


class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();

  final List<Map<String, String>> onboardingData = [
    {
      'image': 'assets/images/onboarding1.png',
      'title': 'Small Steps',
      'title2': 'Big Progress',
      'subtitle': 'Break Your goals into simple steps',
      'subtitle2': 'and build better nabits',
    },
    {
      'image': 'assets/images/onboarding2.png',
      'title': 'Stay Focused',
      'title2': 'Achieve More',
      'subtitle': 'Track your time, reduce',
      'subtitle2': 'distractions and get things done',
    },
    {
      'image': 'assets/images/onboarding3.png',
      'title': 'A Calmer Mind',
      'title2': 'A More Focused You',
      'subtitle': 'Use Personalized Tools like',
      'subtitle2': 'music and breaks to stay\nin flow',
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OnBoardingCubit(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: BlocBuilder<OnBoardingCubit, OnBoardingState>(
            builder: (context, state) {
              int currentIndex = 0;

              if (state is OnBoardingChanged) {
                currentIndex = state.currentIndex;
              }

              final bool isLastPage =
                  currentIndex == onboardingData.length - 1;

              return Column(
                children: [
                  Text(
                    onboardingData[currentIndex]['title']!,
                    style: AppTextstyle.h1,
                  ),

                  Text(
                    onboardingData[currentIndex]['title2']!,
                    style: AppTextstyle.h1,
                  ),

                  Text(
                    onboardingData[currentIndex]['subtitle']!,
                    style: AppTextstyle.h2,
                  ),

                  Text(
                    onboardingData[currentIndex]['subtitle2']!,
                    style: AppTextstyle.h2,
                  ),

                  Expanded(
                    flex: 3,
                    child: OnBoardingWedgit(
                      pageController: _pageController,
                      onboardingData: onboardingData,
                      currentIndex: currentIndex,
                      onPageChanged: (index) {
                        context
                            .read<OnBoardingCubit>()
                            .changeIndex(index);
                      },
                    ),
                  ),

                  20.verticalSpace,

                  MainbuttonWedgit(
                    title: isLastPage ? 'Get Started' : 'Next',
                    onTap: () {
                      if (!isLastPage) {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      } else {
                          Navigator.pushNamed(context, AppRoutes.loginScreen);
                          
                        
                      }
                    },
                  ),

                  20.verticalSpace,
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}