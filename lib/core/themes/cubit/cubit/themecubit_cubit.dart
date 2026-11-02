
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:focus_flow/core/themes/app_colors.dart';

part 'themecubit_state.dart';

class ThemecubitCubit extends Cubit<ThemecubitState> {
  ThemecubitCubit() : super(const ThemecubitInitial());

  void changeColor(Color color) {
    emit(
      ThemecubitState(
        color: color,
        themeMode: state.themeMode,
      ),
    );
  }

  void changeTheme(AppThemeMode mode) {
    emit(
      ThemecubitState(
        color: state.color,
        themeMode: mode,
      ),
    );
  }
}
