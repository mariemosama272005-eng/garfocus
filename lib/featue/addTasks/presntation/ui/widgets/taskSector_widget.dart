
import 'package:flutter/material.dart';
import 'package:focus_flow/core/themes/app_textStyle.dart';

class AddTaskSectionHeader extends StatelessWidget {
  final String title;

  const AddTaskSectionHeader({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: AppTextstyle.h2(context).copyWith(
        fontWeight: FontWeight.bold,
      ),
    );
  }
}