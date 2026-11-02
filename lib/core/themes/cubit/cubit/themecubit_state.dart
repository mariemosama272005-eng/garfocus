part of 'themecubit_cubit.dart';

@immutable
sealed class ThemecubitState {}

final class ThemecubitInitial extends ThemecubitState {
   final Color color;

  ThemecubitInitial(this.color);
}

class ThemecubitChangeColor extends ThemecubitState {
  final Color color;

  ThemecubitChangeColor(this.color);
}
