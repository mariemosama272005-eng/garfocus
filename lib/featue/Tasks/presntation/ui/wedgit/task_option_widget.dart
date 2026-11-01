import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focus_flow/core/themes/app_colors.dart';

class TaskOptionWidget extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String value;
  final List<String> options;
  final Function(String) onSelected;

  const TaskOptionWidget({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.value,
    required this.options,
    required this.onSelected,
  });

 
  Color get currentColor {
    if (title == 'Priority / Urgency') {
      if (value == 'High') return Colors.red;
      if (value == 'Medium') return Colors.blue;
      if (value == 'Low') return Colors.green;
    }
    return iconColor;
  }

  IconData getOptionIcon(String optionText) {
    switch (optionText.toLowerCase()) {
     
      case 'study':
        return Icons.school_outlined;
      case 'work':
        return Icons.work_outline;
      case 'personal':
        return Icons.person_outline;
      case 'health':
        return Icons.favorite_border;
      case 'social':
        return Icons.people_outline;
      case 'admain':
      case 'admin':
        return Icons.admin_panel_settings_outlined;
      case 'other':
        return Icons.category_outlined;

   
      case 'today':
        return Icons.today_outlined;
      case 'tomorrow':
        return Icons.upcoming_outlined;
      case 'this week':
        return Icons.date_range_outlined;
      case 'next week':
        return Icons.next_plan_outlined;

 
      case 'high':
        return Icons.error_outline;
      case 'medium':
        return Icons.warning_amber_rounded;
      case 'low':
        return Icons.check_circle_outline;

      default:
        return icon; 
    }
  }

  @override
  Widget build(BuildContext context) {
   
    final IconData displayedIcon = getOptionIcon(value);

    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: options.map((option) {
                  return ListTile(
                    leading: Icon(
                      getOptionIcon(option), 
                      color: option == 'High'
                          ? Colors.red
                          : option == 'Medium'
                              ? Colors.blue
                              : option == 'Low'
                                  ? Colors.green
                                  : iconColor,
                    ),
                    title: Text(option),
                    trailing: value == option
                        ? Icon(
                            Icons.check,
                            color: AppColors.mainColor,
                          )
                        : null,
                    onTap: () {
                      onSelected(option);
                      Navigator.pop(context);
                    },
                  );
                }).toList(),
              ),
            );
          },
        );
      },
      child: Container(
   padding: EdgeInsets.symmetric(horizontal: 14.w),
        decoration: BoxDecoration(
          border: Border.all(
            color:AppColors.borderColor,
          ),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          children: [
            Container(
              width: 40.w,
       
              decoration: BoxDecoration(
                color: currentColor.withOpacity(0.10),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(
                displayedIcon,
                size: 21.sp,
                color: currentColor,
              ),
            ),
            13.horizontalSpace,
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color:AppColors.hintColor,
                  fontSize: 16,
                ),
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: 15.sp,
                color: currentColor,
                fontWeight: FontWeight.w500,
              ),
            ),
           12.horizontalSpace,
            Icon(
              Icons.arrow_forward_ios,
              size: 15.sp,
              color: AppColors.blackColor,
            ),
          ],
        ),
      ),
    );
  }
}