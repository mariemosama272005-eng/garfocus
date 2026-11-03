import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focus_flow/core/themes/app_colors.dart';

import 'option_icon_widget.dart';
import 'option_title_widget.dart';
import 'option_value_widget.dart';

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

  Color getCurrentColor(BuildContext context) {
    // Category colors
    if (title == 'Category') {
      switch (value.toLowerCase()) {
        case 'study':
          return Theme.of(context).colorScheme.primary;

        case 'work':
          return Theme.of(context).colorScheme.secondary;

        case 'personal':
          return Theme.of(context).colorScheme.tertiary;

        case 'health':
          return Theme.of(context).colorScheme.error;

        case 'social':
          return Theme.of(context).colorScheme.primaryContainer;

        case 'admain':
          return Theme.of(context).colorScheme.secondaryContainer;

        case 'other':
          return Theme.of(context).colorScheme.outline;

        default:
          return iconColor;
      }
    }

    // Priority - unchanged
    if (title == 'Priority / Urgency') {
      switch (value) {
        case 'High':
          return Colors.red;

        case 'Medium':
          return Colors.blue;

        case 'Low':
          return Colors.green;
      }
    }

    return iconColor;
  }

  IconData getOptionIcon(String option) {
    switch (option.toLowerCase()) {
      // Category
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
        return Icons.admin_panel_settings_outlined;

      case 'other':
        return Icons.category_outlined;

      // Priority
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

  void showOptionsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: options.map((option) {
              final bool isSelected = value == option;

              Color optionColor = iconColor;

              // Category colors
              if (title == 'Category') {
                switch (option.toLowerCase()) {
                  case 'study':
                    optionColor =
                        Theme.of(context).colorScheme.primary;
                    break;

                  case 'work':
                    optionColor =
                        Theme.of(context).colorScheme.secondary;
                    break;

                  case 'personal':
                    optionColor =
                        Theme.of(context).colorScheme.tertiary;
                    break;

                  case 'health':
                    optionColor =
                        Theme.of(context).colorScheme.error;
                    break;

                  case 'social':
                    optionColor =
                        Theme.of(context).colorScheme.primaryContainer;
                    break;

                  case 'admain':
                    optionColor =
                        Theme.of(context).colorScheme.secondaryContainer;
                    break;

                  case 'other':
                    optionColor =
                        Theme.of(context).colorScheme.outline;
                    break;
                }
              }

              // Priority - unchanged
              if (title == 'Priority / Urgency') {
                switch (option) {
                  case 'High':
                    optionColor = Colors.red;
                    break;

                  case 'Medium':
                    optionColor = Colors.blue;
                    break;

                  case 'Low':
                    optionColor = Colors.green;
                    break;
                }
              }

              return ListTile(
                leading: Icon(
                  getOptionIcon(option),
                  color: optionColor,
                ),
                title: Text(option),
                trailing: isSelected
                    ? Icon(
                        Icons.check,
                        color: Theme.of(context)
                            .colorScheme
                            .primary,
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
  }

  @override
  Widget build(BuildContext context) {
    final Color currentColor = getCurrentColor(context);

    return InkWell(
      borderRadius: BorderRadius.circular(10.r),
      onTap: () {
        showOptionsBottomSheet(context);
      },
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
              icon: getOptionIcon(value),
              color: currentColor,
            ),

            13.horizontalSpace,

            OptionTitleWidget(
              title: title,
            ),

            OptionValueWidget(
              value: value,
              color: currentColor,
            ),

            12.horizontalSpace,

            Icon(
              Icons.arrow_forward_ios,
              size: 15.sp,
              color: Theme.of(context).colorScheme.primary,
            ),
          ],
        ),
      ),
    );
  }
}