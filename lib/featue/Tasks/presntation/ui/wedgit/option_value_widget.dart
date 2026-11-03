import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OptionValueWidget extends StatelessWidget {
  final String value;
  final Color color;

  const OptionValueWidget({
    super.key,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      style: TextStyle(
        fontSize: 15.sp,
        color: color,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}