import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focus_flow/core/routes/app_routes.dart';
import 'package:focus_flow/core/shared_wedgits/appBar_wedgit.dart';
import 'package:focus_flow/core/shared_wedgits/costumButton_wedgit.dart';
import 'package:focus_flow/core/shared_wedgits/textForm_wedgit.dart';
import 'package:focus_flow/core/themes/app_colors.dart';
import 'package:focus_flow/core/themes/app_textStyle.dart';
import 'package:focus_flow/featue/Tasks/presntation/ui/wedgit/deadline_widgrt.dart';

import 'package:focus_flow/featue/Tasks/presntation/ui/wedgit/task_option_widget.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController titleController = TextEditingController();

  final TextEditingController detailsController =
      TextEditingController();

  String category = 'Personal';

  String priority = 'Medium';

  DateTime? deadlineDate;

  TimeOfDay? deadlineTime;

  @override
  void dispose() {
    titleController.dispose();
    detailsController.dispose();
    super.dispose();
  }

  Future<void> selectDeadline() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: deadlineDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (pickedDate == null) return;

    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: deadlineTime ?? TimeOfDay.now(),
    );

    if (pickedTime == null) return;

    setState(() {
      deadlineDate = pickedDate;
      deadlineTime = pickedTime;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Theme.of(context).scaffoldBackgroundColor,

      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // App Bar
              const AppbarWedgit(
                title: "Add Task",
              ),

              25.verticalSpace,

              // AI Hint
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 15.h,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.auto_awesome,
                      size: 20.sp,
                      color: Theme.of(context)
                          .colorScheme
                          .primary,
                    ),

                    SizedBox(width: 10.w),

                    Expanded(
                      child: Text(
                        'Let AI help you create the best plan',
                        style:
                            AppTextstyle.hintTextStyle(context),
                      ),
                    ),
                  ],
                ),
              ),

              28.verticalSpace,

              // Task Title
              Text(
                'What do you want to do ?',
                style: AppTextstyle
                    .h2(context)
                    .copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),

              12.verticalSpace,

              TextformWedgit(
                controller: titleController,
                hintT: 'What do you want to do?',
                isPass: false,
              ),

              25.verticalSpace,

              // Additional Details
              Text(
                'Additional details ( optional )',
                style: AppTextstyle
                    .h2(context)
                    .copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),

              14.verticalSpace,

              // Category
              TaskOptionWidget(
                icon: Icons.category_outlined,
                title: 'Category',
                value: category,
                options: const [
                  'Study',
                  'Work',
                  'Personal',
                  'Health',
                  'Social',
                  'Admin',
                  'Other',
                ],
                onSelected: (value) {
                  setState(() {
                    category = value;
                  });
                },
                iconColor: AppColors.mainColor,
              ),

              12.verticalSpace,

              // Deadline
              DeadlineOptionWidget(
                selectedDate: deadlineDate,
                selectedTime: deadlineTime,
                onTap: selectDeadline,
              ),

              12.verticalSpace,

              // Priority
              TaskOptionWidget(
                icon: Icons.flag_outlined,
                title: 'Priority / Urgency',
                value: priority,
                options: const [
                  'Low',
                  'Medium',
                  'High',
                ],
                onSelected: (value) {
                  setState(() {
                    priority = value;
                  });
                },
                iconColor: Colors.blue,
              ),

              18.verticalSpace,

              // Details
              TextformWedgit(
                controller: detailsController,
                hintT: 'Add more details about your task...',
                isPass: false,
              ),

              30.verticalSpace,

              // Set Task
              MainbuttonWedgit(
                title: "Set Task",
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.homeScreen,
                  );
                },
              ),

              30.verticalSpace,

              Center(
                child: Text(
                  "Or",
                  style: AppTextstyle.hint24(context),
                ),
              ),

              20.verticalSpace,

              // AI
              MainbuttonWedgit(
                title: "✨ Create with AI",
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.aiCreatingPlanScreen,
                  );
                },
              ),

              25.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}