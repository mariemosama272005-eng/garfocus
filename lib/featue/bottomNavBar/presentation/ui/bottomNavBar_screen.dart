
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:focus_flow/core/routes/app_routes.dart';

import 'package:focus_flow/featue/Home/presntation/ui/home_screen.dart';
import 'package:focus_flow/featue/Settings/presntation/ui/apperance_screen.dart';

import 'package:focus_flow/featue/bottomNavBar/presentation/ui/widget/navBarItem_widget.dart';

import 'package:focus_flow/featue/tasks/presentation/ui/task_screen.dart';
import 'package:focus_flow/featue/tasks/presentation/cubit/cubit/task_cubit_cubit.dart';

class ButtomNavBarScreen extends StatefulWidget {
  final int initialIndex;

  const ButtomNavBarScreen({
    super.key,
    this.initialIndex = 0,
  });

  @override
  State<ButtomNavBarScreen> createState() =>
      _ButtomNavBarScreenState();
}

class _ButtomNavBarScreenState
    extends State<ButtomNavBarScreen> {

  late int selectedIndex;

  static const Color primaryColor =
      Color(0xFF7653D6);

  final List<Widget> screens = const [
    HomeScreen(),
    TaskScreen(),
    Center(
      child: Text('Profile'),
    ),
    AppearanceScreen(),
  ];

  @override
  void initState() {
    super.initState();

    selectedIndex = widget.initialIndex;
  }

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  Future<void> _addTask() async {

    // استخدام نفس TaskCubit الموجود في Bottom Navigation

    final taskCubit = context.read<TaskCubitCubit>();

    final result = await Navigator.pushNamed(
      context,
      AppRoutes.addTaskScreen,

      arguments: {
        'taskCubit': taskCubit,
      },
    );

    if (!mounted) return;

    if (result == true) {

      setState(() {
        selectedIndex = 1;
      });

      // تحديث قائمة المهام بعد الرجوع

      taskCubit.getTasks();
    }
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
        onPressed: _addTask,
        backgroundColor: primaryColor,
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
            mainAxisAlignment:
                MainAxisAlignment.spaceAround,

            children: [

              NavBarItemWidget(
                icon: Icons.home_rounded,
                label: 'Home',
                index: 0,
                selectedIndex: selectedIndex,
                onTap: _onItemTapped,
              ),

              NavBarItemWidget(
                icon: Icons.task_alt_rounded,
                label: 'Tasks',
                index: 1,
                selectedIndex: selectedIndex,
                onTap: _onItemTapped,
              ),

              SizedBox(width: 45.w),

              NavBarItemWidget(
                icon: Icons.person_rounded,
                label: 'Profile',
                index: 2,
                selectedIndex: selectedIndex,
                onTap: _onItemTapped,
              ),

              NavBarItemWidget(
                icon: Icons.settings_rounded,
                label: 'Settings',
                index: 3,
                selectedIndex: selectedIndex,
                onTap: _onItemTapped,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
