import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:focus_flow/core/shared_wedgits/appBar_wedgit.dart';
import 'package:focus_flow/featue/tasks/presentation/cubit/cubit/task_cubit_cubit.dart';
import 'package:focus_flow/featue/tasks/presentation/ui/widgets/taskCard_widget.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 24.w,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppbarWedgit(
                title: "Tasks",
              ),

              25.verticalSpace,

              Text(
                "Today's Tasks",
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),

              15.verticalSpace,

              Expanded(
                child: BlocBuilder<TaskCubitCubit, TaskCubitState>(
                  builder: (context, state) {
                    if (state is TaskCubitLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (state is TaskCubitError) {
                      return Center(
                        child: Text(
                          state.message,
                          textAlign: TextAlign.center,
                        ),
                      );
                    }

                    if (state is TaskCubitLoaded) {
                      final tasks = state.tasks;

                      if (tasks.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.task_alt,
                                size: 70.sp,
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary,
                              ),

                              15.verticalSpace,

                              Text(
                                "No tasks yet",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),

                              8.verticalSpace,

                              Text(
                                "Add your first task to get started",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium,
                              ),
                            ],
                          ),
                        );
                      }

                      return ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemCount: tasks.length,
                        separatorBuilder: (context, index) {
                          return 12.verticalSpace;
                        },
                        itemBuilder: (context, index) {
                          final task = tasks[index];

                          return TaskCardWidget(
                            task: task,
                          );
                        },
                      );
                    }

                    return const SizedBox();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}