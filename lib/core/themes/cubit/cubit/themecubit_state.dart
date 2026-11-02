
part of 'themecubit_cubit.dart';

enum AppThemeMode {
  light,
  dark,
  system,
}

@immutable
class ThemecubitState {
  final Color color;
  final AppThemeMode themeMode;

  const ThemecubitState({
    required this.color,
    required this.themeMode,
  });
}

final class ThemecubitInitial extends ThemecubitState {
  const ThemecubitInitial()
      : super(
          color: AppColors.mainColor,
          themeMode: AppThemeMode.system,
        );
}
