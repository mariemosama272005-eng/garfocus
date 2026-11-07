
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:focus_flow/featue/addTasks/presntation/ui/widgets/optinValue.dart';
import 'package:focus_flow/featue/addTasks/presntation/ui/widgets/option_widget.dart';
import 'package:focus_flow/featue/addTasks/presntation/ui/widgets/titleOption_widget.dart';

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

  Color _getItemColor(BuildContext context, String itemValue) {
    if (title == 'Category') {
      switch (itemValue.toLowerCase()) {
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
        case 'admin':
          return Theme.of(context).colorScheme.secondaryContainer;
        case 'other':
          return Theme.of(context).colorScheme.outline;
        default:
          return iconColor;
      }
    }

    if (title == 'Priority / Urgency') {
      switch (itemValue) {
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

  IconData _getOptionIcon(String option) {
    switch (option.toLowerCase()) {
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
      case 'admin':
        return Icons.admin_panel_settings_outlined;
      case 'other':
        return Icons.category_outlined;
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

  void _showOptionsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.r),
        ),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: options.map((option) {
                final bool isSelected = value == option;
                final Color optionColor =
                    _getItemColor(context, option);

                return ListTile(
                  leading: Icon(
                    _getOptionIcon(option),
                    color: optionColor,
                  ),
                  title: Text(
                    option,
                    style: TextStyle(
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                  trailing: isSelected
                      ? Icon(
                          Icons.check,
                          color: Theme.of(context).colorScheme.primary,
                        )
                      : null,
                  onTap: () {
                    onSelected(option);
                    Navigator.pop(context);
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color currentColor = _getItemColor(context, value);

    return InkWell(
      borderRadius: BorderRadius.circular(10.r),
      onTap: () => _showOptionsBottomSheet(context),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 14.w,
          vertical: 12.h,
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
              icon: _getOptionIcon(value),
              color: currentColor,
            ),

            13.horizontalSpace,

            Expanded(
              child: OptionTitleWidget(
                title: title,
              ),
            ),

            8.horizontalSpace,

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
