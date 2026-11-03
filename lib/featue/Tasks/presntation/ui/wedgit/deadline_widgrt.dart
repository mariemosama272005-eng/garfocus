import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focus_flow/core/themes/app_colors.dart';
import 'option_icon_widget.dart';
import 'option_title_widget.dart';

class DeadlineOptionWidget extends StatelessWidget {
  final DateTime? selectedDate;
  final TimeOfDay? selectedTime;
  final VoidCallback onTap;

  const DeadlineOptionWidget({
    super.key,
    required this.selectedDate,
    required this.selectedTime,
    required this.onTap,
  });

  String getDateText() {
    if (selectedDate == null) {
      return 'Set deadline';
    }

    return '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}';
  }

  @override
  Widget build(BuildContext context) {
    String value = getDateText();

    if (selectedTime != null) {
      value += ' - ${selectedTime!.format(context)}';
    }

    return InkWell(
      borderRadius: BorderRadius.circular(10.r),
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 14.w,
          vertical: 8.h,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).colorScheme.outline,
          ),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          children: [
            OptionIconWidget(
              icon: Icons.calendar_today_outlined,
              color: 	Theme.of(context).colorScheme.primary,
            ),

            13.horizontalSpace,

            const OptionTitleWidget(
              title: 'Deadline',
              
            ),

            Text(
              value,
              style: TextStyle(
                fontSize: 15.sp,
                color: selectedDate != null
                    ? Theme.of(context).colorScheme.primary
                    : 	Theme.of(context).colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w500,
              ),
            ),

            12.horizontalSpace,

            Icon(
              Icons.arrow_forward_ios,
              size: 15.sp,
              color: 	Theme.of(context).colorScheme.primary,
            ),
          ],
        ),
      ),
    );
  }
}