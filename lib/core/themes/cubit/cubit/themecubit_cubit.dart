import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:focus_flow/core/services/local/local_helper.dart';
import 'package:focus_flow/core/themes/app_colors.dart';

part 'themecubit_state.dart';

class ThemecubitCubit extends Cubit<ThemecubitState> {
  ThemecubitCubit() : super(const ThemecubitInitial()) {
    loadTheme();
  }

  static const String themeModeKey = 'theme_mode';
  static const String themeColorKey = 'theme_color';

  Future<void> changeColor(Color color) async {
    await LocalHelper.setInt(
      themeColorKey,
      color.toARGB32(),
    );

    emit(
      ThemecubitState(
        color: color,
        themeMode: state.themeMode,
      ),
    );
  }

  Future<void> changeTheme(AppThemeMode mode) async {
    await LocalHelper.setString(
      themeModeKey,
      mode.name,
    );

    emit(
      ThemecubitState(
        color: state.color,
        themeMode: mode,
      ),
    );
  }

  void loadTheme() {
    final savedColor = LocalHelper.getInt(themeColorKey);
    final savedMode = LocalHelper.getString(themeModeKey);

    final color = savedColor != null
        ? Color(savedColor)
        : AppColors.mainColor;

    final mode = savedMode != null
        ? AppThemeMode.values.firstWhere(
            (element) => element.name == savedMode,
            orElse: () => AppThemeMode.system,
          )
        : AppThemeMode.system;

    emit(
      ThemecubitState(
        color: color,
        themeMode: mode,
      ),
    );
  }
}