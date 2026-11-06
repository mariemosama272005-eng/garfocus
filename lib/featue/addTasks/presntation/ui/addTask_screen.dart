
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:focus_flow/core/routes/app_routes.dart';
import 'package:focus_flow/core/shared_wedgits/appBar_wedgit.dart';
import 'package:focus_flow/core/shared_wedgits/costumButton_wedgit.dart';
import 'package:focus_flow/core/shared_wedgits/textForm_wedgit.dart';
import 'package:focus_flow/core/themes/app_colors.dart';
import 'package:focus_flow/core/themes/app_textStyle.dart';
import 'package:focus_flow/featue/addTasks/presntation/ui/widgets/deadline_widget.dart';
import 'package:focus_flow/featue/addTasks/presntation/ui/widgets/taskOption_widget.dart';
import 'package:focus_flow/featue/tasks/Data/models/task_model.dart';

import 'package:focus_flow/featue/tasks/data/models/task_model.dart' hide TaskModel;
import 'package:focus_flow/featue/tasks/presentation/cubit/cubit/task_cubit_cubit.dart';



class AddTaskScreen extends StatefulWidget {
 final TaskModel? task;

const AddTaskScreen({
  super.key,
  this.task,
});
  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController titleController =
      TextEditingController();

  final TextEditingController detailsController =
      TextEditingController();

  String category = 'Personal';
  String priority = 'Medium';

  DateTime? deadlineDate;
  TimeOfDay? deadlineTime;
  @override
void initState() {
  super.initState();

  if (widget.task != null) {
    titleController.text = widget.task!.title;
    detailsController.text = widget.task!.details;

    category = widget.task!.category;
    priority = widget.task!.priority;

    deadlineDate = widget.task!.deadlineDate;

    if (widget.task!.deadlineMinutes != null) {
      final minutes = widget.task!.deadlineMinutes!;

      deadlineTime = TimeOfDay(
        hour: minutes ~/ 60,
        minute: minutes % 60,
      );
    }
  }
}

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

 Future<void> saveTask() async {
  if (titleController.text.trim().isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Please enter a task title'),
      ),
    );
    return;
  }

  int? deadlineMinutes;

  if (deadlineTime != null) {
    deadlineMinutes =
        deadlineTime!.hour * 60 + deadlineTime!.minute;
  }

  final TaskModel task = widget.task ?? TaskModel(
    title: '',
    details: '',
    category: '',
    priority: '',
  );

  task
    ..title = titleController.text.trim()
    ..details = detailsController.text.trim()
    ..category = category
    ..deadlineDate = deadlineDate
    ..deadlineMinutes = deadlineMinutes
    ..priority = priority;

  final cubit = context.read<TaskCubitCubit>();

  final success = widget.task == null
      ? await cubit.addTask(task)
      : await cubit.updateTask(task);

  if (!mounted) return;

  if (success) {
    Navigator.pushNamed(context, AppRoutes.bottomNavbarScreen);
  }
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
             AppbarWedgit(
  title: widget.task == null ? 'Add Task' : 'Edit Task',
),

              25.verticalSpace,

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
                        style: AppTextstyle.hintTextStyle(
                          context,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              28.verticalSpace,

              Text(
                'What do you want to do ?',
                style: AppTextstyle.h2(context).copyWith(
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

              Text(
                'Additional details ( optional )',
                style: AppTextstyle.h2(context).copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),

              14.verticalSpace,

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

              DeadlineOptionWidget(
                selectedDate: deadlineDate,
                selectedTime: deadlineTime,
                onTap: selectDeadline,
              ),

              12.verticalSpace,

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

              TextformWedgit(
                controller: detailsController,
                hintT: 'Add more details about your task...',
                isPass: false,
              ),

              30.verticalSpace,

              MainbuttonWedgit(
                title: "Set Task",
                onTap: saveTask,

              ),

              30.verticalSpace,

              Center(
                child: Text(
                  "Or",
                  style: AppTextstyle.hint24(context),
                ),
              ),

              20.verticalSpace,

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