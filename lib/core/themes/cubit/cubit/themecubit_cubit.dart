import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:focus_flow/core/themes/app_colors.dart';

part 'themecubit_state.dart';

class ThemecubitCubit extends Cubit<ThemecubitState> {
  ThemecubitCubit()
      : super(ThemecubitInitial(AppColors.mainColor));

  void changeColor(Color color) {
    emit(ThemecubitChangeColor(color));
  }
}