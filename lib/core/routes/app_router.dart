
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:focus_flow/core/routes/app_routes.dart';
import 'package:focus_flow/core/services/local/local_helper.dart';

import 'package:focus_flow/featue/Authentication/presntation/ui/login_screen.dart';
import 'package:focus_flow/featue/Authentication/presntation/ui/register_screen.dart';
import 'package:focus_flow/featue/Authentication/presntation/ui/forget_password_screen.dart';
import 'package:focus_flow/featue/Authentication/presntation/ui/otp_screen.dart';
import 'package:focus_flow/featue/Authentication/presntation/ui/create_new_password_screen.dart';

import 'package:focus_flow/featue/FocusSession/presntation/cubit/cubit/focus_cubit.dart';
import 'package:focus_flow/featue/FocusSession/presntation/ui/focus_screen.dart';

import 'package:focus_flow/featue/Home/data/repo/gamification_repo.dart';
import 'package:focus_flow/featue/Home/presntation/cubit/cubit/gamification_cubit.dart';
import 'package:focus_flow/featue/Home/presntation/ui/home_screen.dart';

import 'package:focus_flow/featue/Onboarding/presntation/cubit/cubit/on_boarding_cubit.dart';
import 'package:focus_flow/featue/Onboarding/presntation/ui/onborading_screen.dart';

import 'package:focus_flow/featue/Settings/presntation/ui/apperance_screen.dart';

import 'package:focus_flow/featue/addTasks/presntation/cubit/cubit/add_task_cubit.dart';
import 'package:focus_flow/featue/addTasks/presntation/ui/addTask_screen.dart';
import 'package:focus_flow/featue/addTasks/presntation/ui/aiCreatingPlan.dart';

import 'package:focus_flow/featue/bottomNavBar/presentation/ui/bottomNavBar_screen.dart';

import 'package:focus_flow/featue/tasks/Data/models/task_model.dart';
import 'package:focus_flow/featue/tasks/Data/repo/task_repo.dart';
import 'package:focus_flow/featue/tasks/presentation/cubit/cubit/task_cubit_cubit.dart';
import 'package:focus_flow/featue/tasks/presentation/ui/task_screen.dart';

class AppRouter {

  static Route? onGenerateRoute(RouteSettings setting) {

    switch (setting.name) {

      // ONBOARDING

      case AppRoutes.OnboardingScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<OnBoardingCubit>(
            create: (_) => OnBoardingCubit(),
            child: const OnboardingScreen(),
          ),
        );

      // AUTH

      case AppRoutes.loginScreen:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        );

      case AppRoutes.registerScreen:
        return MaterialPageRoute(
          builder: (_) => const RegisterScreen(),
        );

      case AppRoutes.forgetpassScreen:
        return MaterialPageRoute(
          builder: (_) => const ForgetPasswordScreen(),
        );

      case AppRoutes.otpScreen:
        return MaterialPageRoute(
          builder: (_) => const OtpScreen(),
        );

      case AppRoutes.createNewPasswordScreen:
        return MaterialPageRoute(
          builder: (_) => const CreateNewPasswordScreen(),
        );

      // HOME

      case AppRoutes.homeScreen:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [

              BlocProvider<GamificationCubit>(
                create: (_) => GamificationCubit(
                  GamificationRepository(
                    LocalHelper.prefs!,
                  ),
                ),
              ),

              BlocProvider<TaskCubitCubit>(
                create: (context) => TaskCubitCubit(
                  TaskRepository(
                    Hive.box<TaskModel>('tasksBox'),
                  ),
                  context.read<GamificationCubit>(),
                )..getTasks(),
              ),
            ],
            child: const HomeScreen(),
          ),
        );

      // ADD TASK

      case AppRoutes.addTaskScreen:

        final arguments = setting.arguments;

        TaskModel? task;
        TaskCubitCubit? taskCubit;

        if (arguments is TaskModel) {
          task = arguments;
        }

        if (arguments is Map<String, dynamic>) {
          task = arguments['task'] as TaskModel?;
          taskCubit = arguments['taskCubit'] as TaskCubitCubit?;
        }

        // حفظ نسخة من البيانات لاستخدامها داخل builder

        final selectedTask = task;
        final selectedTaskCubit = taskCubit;

        return MaterialPageRoute(
          builder: (_) {

            if (selectedTaskCubit == null) {
              return const Scaffold(
                body: Center(
                  child: Text(
                    'TaskCubit was not provided',
                  ),
                ),
              );
            }

            return BlocProvider<AddTaskCubit>(
              create: (_) => AddTaskCubit(
                selectedTaskCubit,
                selectedTask,
              ),

              child: AddTaskScreen(
                task: selectedTask,
              ),
            );
          },
        );

      // AI PLAN

      case AppRoutes.aiCreatingPlanScreen:
        return MaterialPageRoute(
          builder: (_) => const AiCreatingPlanScreen(),
        );

      // APPEARANCE

      case AppRoutes.apperanceScreen:
        return MaterialPageRoute(
          builder: (_) => const AppearanceScreen(),
        );

      // FOCUS

      case AppRoutes.focusScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<FocusCubit>(
            create: (_) => FocusCubit(),
            child: const FocusScreen(),
          ),
        );

      // TASK SCREEN

      case AppRoutes.taskScreen:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [

              BlocProvider<GamificationCubit>(
                create: (_) => GamificationCubit(
                  GamificationRepository(
                    LocalHelper.prefs!,
                  ),
                ),
              ),

              BlocProvider<TaskCubitCubit>(
                create: (context) => TaskCubitCubit(
                  TaskRepository(
                    Hive.box<TaskModel>('tasksBox'),
                  ),
                  context.read<GamificationCubit>(),
                )..getTasks(),
              ),
            ],

            child: const TaskScreen(),
          ),
        );

      // BOTTOM NAVBAR

      case AppRoutes.bottomNavbarScreen:

        int initialIndex = 0;

        final arguments = setting.arguments;

        if (arguments is Map<String, dynamic>) {
          initialIndex =
              arguments['initialIndex'] as int? ?? 0;
        }

        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [

              BlocProvider<GamificationCubit>(
                create: (_) => GamificationCubit(
                  GamificationRepository(
                    LocalHelper.prefs!,
                  ),
                ),
              ),

              BlocProvider<TaskCubitCubit>(
                create: (context) => TaskCubitCubit(
                  TaskRepository(
                    Hive.box<TaskModel>('tasksBox'),
                  ),
                  context.read<GamificationCubit>(),
                )..getTasks(),
              ),
            ],

            child: ButtomNavBarScreen(
              initialIndex: initialIndex,
            ),
          ),
        );

      default:
        return null;
    }
  }
}
