
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppbarWedgit extends StatelessWidget {
  final String? title;
  final VoidCallback? onBackPressed;
  final List<Widget>? actions;

  const AppbarWedgit({
    super.key,
    this.title,
    this.onBackPressed,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return AppBar(
      backgroundColor: theme.scaffoldBackgroundColor,
      foregroundColor: colorScheme.onSurface,
      title: title != null ? Text(title!) : null,
      centerTitle: true,
      elevation: 0,
      actions: actions,
      leading: Container(
        width: 41.w,
        height: 41.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40.r),
          color: theme.cardColor,
        ),
        child: BackButton(
          color: colorScheme.onSurface,
          onPressed: () {
            if (onBackPressed != null) {
              onBackPressed!();
            } else {
              Navigator.maybePop(context);
            }
          },
        ),
      ),
    );
  }
}
