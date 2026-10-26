part of 'on_boarding_cubit.dart';

@immutable
sealed class OnBoardingState {}

final class OnBoardingInitial extends OnBoardingState {}
final class OnBoardingChanged extends OnBoardingState {
  final int currentIndex;
  OnBoardingChanged(this.currentIndex);
}
