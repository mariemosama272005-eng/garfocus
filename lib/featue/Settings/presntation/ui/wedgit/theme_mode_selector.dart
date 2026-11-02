
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_flow/core/themes/cubit/cubit/themecubit_cubit.dart';

class ThemeModeSelector extends StatelessWidget {
  const ThemeModeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemecubitCubit, ThemecubitState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'App Theme',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 15),
            SegmentedButton<AppThemeMode>(
              segments: const [
                ButtonSegment(
                  value: AppThemeMode.light,
                  label: Text('Light'),
                  icon: Icon(Icons.light_mode),
                ),
                ButtonSegment(
                  value: AppThemeMode.dark,
                  label: Text('Dark'),
                  icon: Icon(Icons.dark_mode),
                ),
                ButtonSegment(
                  value: AppThemeMode.system,
                  label: Text('System'),
                  icon: Icon(Icons.settings_brightness),
                ),
              ],
              selected: {state.themeMode},
              onSelectionChanged: (value) {
                context
                    .read<ThemecubitCubit>()
                    .changeTheme(value.first);
              },
            ),
          ],
        );
      },
    );
  }
}
