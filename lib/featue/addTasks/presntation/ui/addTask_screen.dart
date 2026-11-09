
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focus_flow/core/routes/app_routes.dart';
import 'package:focus_flow/core/shared_wedgits/appBar_wedgit.dart';
import 'package:focus_flow/core/shared_wedgits/costumButton_wedgit.dart';
import 'package:focus_flow/core/shared_wedgits/textForm_wedgit.dart';
import 'package:focus_flow/core/themes/app_textStyle.dart';
import 'package:focus_flow/featue/addTasks/presntation/ui/aiBanner_Widget.dart';
import 'package:focus_flow/featue/addTasks/presntation/cubit/cubit/add_task_cubit.dart';
import 'package:focus_flow/featue/addTasks/presntation/ui/widgets/deadline_widget.dart';
import 'package:focus_flow/featue/addTasks/presntation/ui/widgets/taskOption_widget.dart';

import 'package:focus_flow/featue/tasks/Data/models/task_model.dart';

class AddTaskScreen extends StatelessWidget {
  final TaskModel? task;

  const AddTaskScreen({
    super.key,
    this.task,
  });

  @override
  Widget build(BuildContext context) {
    return const AddTaskScreenBody();
  }
}

class AddTaskScreenBody extends StatefulWidget {
  const AddTaskScreenBody({
    super.key,
  });

  @override
  State<AddTaskScreenBody> createState() =>
      _AddTaskScreenBodyState();
}

class _AddTaskScreenBodyState
    extends State<AddTaskScreenBody> {

  late final TextEditingController titleController;
  late final TextEditingController detailsController;

  @override
  void initState() {
    super.initState();

    final task = context.read<AddTaskCubit>().oldTask;

    titleController = TextEditingController(
      text: task?.title ?? '',
    );

    detailsController = TextEditingController(
      text: task?.details ?? '',
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    detailsController.dispose();
    super.dispose();
  }

  Future<void> _selectDeadline(
    AddTaskCubit cubit,
  ) async {
    final DateTime? pickedDate =
        await showDatePicker(
      context: context,
      initialDate:
          cubit.deadlineDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2027),
    );

    if (pickedDate == null || !mounted) {
      return;
    }

    final TimeOfDay? pickedTime =
        await showTimePicker(
      context: context,
      initialTime:
          cubit.deadlineTime ?? TimeOfDay.now(),
    );

    if (pickedTime == null || !mounted) {
      return;
    }

    cubit.setDeadline(
      pickedDate,
      pickedTime,
    );
  }

  Future<void> _saveTask() async {

    if (titleController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please enter a task title',
            style: AppTextstyle.subTitle(context),
          ),
        ),
      );

      return;
    }

    final cubit = context.read<AddTaskCubit>();
    final success = await cubit.saveTask(
      title: titleController.text.trim(),
      details: detailsController.text.trim(),
    );
    if (!mounted) return;
    if (success) {
      Navigator.pop(context, true);
    } else {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Failed to save task. Please try again.',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<AddTaskCubit, AddTaskState>(
      listener: (context, state) {},

      builder: (context, state) {

        final cubit = context.read<AddTaskCubit>();
        final isEditing = cubit.oldTask != null;

        return Scaffold(
          backgroundColor:
              Theme.of(context).scaffoldBackgroundColor,

          body: SafeArea(
            child: SingleChildScrollView(
              physics:
                  const BouncingScrollPhysics(),

              padding: EdgeInsets.symmetric(
                horizontal: 24.w,
              ),

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  AppbarWedgit(
                    title: isEditing
                        ? 'Edit Task'
                        : 'Add Task',
                  ),

                  25.verticalSpace,

                  const AiBannerWidget(),

                  28.verticalSpace,

                  const AddTaskSectionHeader(
                    title: 'What do you want to do ?',
                  ),

                  12.verticalSpace,

                  TextformWedgit(
                    controller: titleController,
                    hintT: 'What do you want to do?',
                    isPass: false,
                  ),

                  25.verticalSpace,

                  const AddTaskSectionHeader(
                    title: 'Additional details ( optional )',
                  ),

                  14.verticalSpace,

                  TaskOptionWidget(
                    icon: Icons.category_outlined,
                    title: 'Category',
                    value: cubit.category,
                    options: const [
                      'Study',
                      'Work',
                      'Personal',
                      'Health',
                      'Social',
                      'Admin',
                      'Other',
                    ],
                    onSelected: (val) {
                      cubit.setCategory(val);
                    },
                    iconColor: Colors.purple,
                  ),

                  12.verticalSpace,

                  DeadlineOptionWidget(
                    selectedDate: cubit.deadlineDate,
                    selectedTime: cubit.deadlineTime,
                    onTap: () => _selectDeadline(cubit),
                  ),

                  12.verticalSpace,

                  TaskOptionWidget(
                    icon: Icons.flag_outlined,
                    title: 'Priority / Urgency',

                    value:
                        cubit.priority.name[0].toUpperCase() +
                        cubit.priority.name.substring(1),

                    options: const [
                      'High',
                      'Medium',
                      'Low',
                    ],

                    onSelected: (value) {

                      final priority =
                          TaskPriority.values.firstWhere(
                        (e) =>
                            e.name.toLowerCase() ==
                            value.toLowerCase(),
                        orElse: () => TaskPriority.medium,
                      );

                      cubit.setPriority(priority);
                    },

                    iconColor: Colors.blue,
                  ),

                  18.verticalSpace,

                  TextformWedgit(
                    controller: detailsController,
                    hintT:
                        'Add more details about your task...',
                    isPass: false,
                  ),

                  30.verticalSpace,

                  MainbuttonWedgit(
                    title: isEditing
                        ? 'Update Task'
                        : 'Set Task',
                    onTap: () {
                      _saveTask();
                    },
                  ),

                  30.verticalSpace,

                  Center(
                    child: Text(
                      'Or',
                      style: AppTextstyle.hint24(context),
                    ),
                  ),

                  20.verticalSpace,

                  MainbuttonWedgit(
                    title: '✨ Create with AI',
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
      },
    );
  }
}
class AddTaskSectionHeader extends StatelessWidget {
  final String title;
  const AddTaskSectionHeader({
    super.key,
    required this.title,
  });
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: AppTextstyle.h2(context).copyWith(
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
