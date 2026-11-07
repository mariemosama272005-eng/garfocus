import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FocusDialogs {
  static void showBreakOverDialog(BuildContext context, {required VoidCallback onOkPressed}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Break Over! 💪'),
        content: const Text('Your break time is over. Ready to get back to work with full focus?'),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            ),
            onPressed: () {
              Navigator.pop(dialogContext);
              onOkPressed();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  static void showFocusCompleteDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            const Text('Outstanding! '),
            Text('🌟', style: TextStyle(fontSize: 22.sp)),
          ],
        ),
        content: Text(
          'Every single minute you invest today builds the extraordinary future you deserve. Keep shining!',
          style: TextStyle(height: 1.4, fontSize: 14.sp),
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
            ),
            onPressed: () {
              Navigator.pop(dialogContext);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const Scaffold(
                    body: Center(child: Text('Home Screen')),
                  ),
                ),
              );
            },
            child: Text(
              'Home',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
            ),
          ),
        ],
      ),
    );
  }
}