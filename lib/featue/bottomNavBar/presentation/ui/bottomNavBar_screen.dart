
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focus_flow/core/routes/app_router.dart';
import 'package:focus_flow/core/routes/app_routes.dart';

import 'package:focus_flow/featue/Home/presntation/ui/home_screen.dart';
import 'package:focus_flow/featue/tasks/presentation/ui/task_screen.dart';


class ButtomNavBarScreen extends StatefulWidget {
  const ButtomNavBarScreen({super.key});

  @override
  State<ButtomNavBarScreen> createState() =>
      _ButtomNavBarScreenState();
}

class _ButtomNavBarScreenState
    extends State<ButtomNavBarScreen> {

  int selectedIndex = 0;

  final List<Widget> screens = [
  HomeScreen(),
  TaskScreen(),
   Text("profile"),
   Text("settinh=gs") 


  ];

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  void addTask() {
Navigator.pushNamed(context, AppRoutes.addTaskScreen);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: IndexedStack(
        index: selectedIndex,
        children: screens,
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: addTask,
        backgroundColor: const Color(0xFF7653D6),
        elevation: 4,
        shape: const CircleBorder(),
        child: const Icon(
          Icons.add_rounded,
          color: Colors.white,
          size: 32,
        ),
      ),

      floatingActionButtonLocation:
          FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        color: theme.cardColor,
        elevation: 10,
        child: SizedBox(
          height: 65.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [

              _navItem(
                icon: Icons.home_rounded,
                label: 'Home',
                index: 0,
              ),

              _navItem(
                icon: Icons.task_alt_rounded,
                label: 'Tasks',
                index: 1,
              ),

              SizedBox(width: 45.w),

              _navItem(
                icon: Icons.person_rounded,
                label: 'Profile',
                index: 2,
              ),

              _navItem(
                icon: Icons.settings_rounded,
                label: 'Settings',
                index: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _navItem({
    required IconData icon,
    required String label,
    required int index,
  }) {
    final isSelected = selectedIndex == index;

    return InkWell(
      onTap: () => onItemTapped(index),
      borderRadius: BorderRadius.circular(15.r),
      child: SizedBox(
        width: 58.w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 23.sp,
              color: isSelected
                  ? const Color(0xFF7653D6)
                  : Colors.grey,
            ),

            SizedBox(height: 3.h),

            Text(
              label,
              style: TextStyle(
                fontSize: 10.sp,
                fontWeight: isSelected
                    ? FontWeight.bold
                    : FontWeight.normal,
                color: isSelected
                    ? const Color(0xFF7653D6)
                    : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
