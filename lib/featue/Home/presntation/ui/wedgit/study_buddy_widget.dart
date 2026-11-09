import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focus_flow/featue/Home/data/models/gamification_model.dart';
import 'package:focus_flow/featue/Home/data/supportive_messages_provider.dart';
import 'package:focus_flow/featue/Home/presntation/cubit/cubit/gamification_cubit.dart';
import 'package:focus_flow/featue/tasks/Data/models/task_model.dart';
import 'package:focus_flow/featue/tasks/presentation/cubit/cubit/task_cubit_cubit.dart';
import 'package:focus_flow/gen/assets.gen.dart';

class StudyBuddyWidget extends StatefulWidget {
  const StudyBuddyWidget({super.key});

  @override
  State<StudyBuddyWidget> createState() => _StudyBuddyWidgetState();
}

class _StudyBuddyWidgetState extends State<StudyBuddyWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _bounceController;
  late final Animation<double> _bounceAnimation;
  late final Animation<double> _breatheAnimation;

  int _messageIndex = 0;
  String? _recentReaction;

  static const List<String> _tapReactions = [
    '✨ You got this!',
    '🚀 One small step!',
    '🔥 Building momentum!',
    '🎯 Pure focus!',
    '💪 Showing up counts!',
  ];

  @override
  void initState() {
    super.initState();
    _bounceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );

    // Subtle breathing/floating effect
    _breatheAnimation = Tween<double>(begin: 0.0, end: -6.0).animate(
      CurvedAnimation(
        parent: _bounceController,
        curve: Curves.easeInOutSine,
      ),
    );

    // Micro bounce on tap
    _bounceAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.12), weight: 30),
      TweenSequenceItem(tween: Tween(begin: 1.12, end: 0.95), weight: 30),
      TweenSequenceItem(tween: Tween(begin: 0.95, end: 1.0), weight: 40),
    ]).animate(
      CurvedAnimation(
        parent: _bounceController,
        curve: const Interval(0.0, 0.4, curve: Curves.easeOut),
      ),
    );

    _bounceController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _bounceController.dispose();
    super.dispose();
  }

  void _onBuddyTapped(int totalMessages) {
    setState(() {
      _messageIndex = (_messageIndex + 1) % (totalMessages > 0 ? totalMessages : 1);
      _recentReaction =
          _tapReactions[_messageIndex % _tapReactions.length];
    });

    // Quick burst pulse
    _bounceController.forward(from: 0.0).then((_) {
      if (mounted) {
        _bounceController.repeat(reverse: true);
      }
    });

    // Auto-clear reaction hint
    Future.delayed(const Duration(milliseconds: 1600), () {
      if (mounted) {
        setState(() {
          _recentReaction = null;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final primaryColor = theme.colorScheme.primary;

    return BlocBuilder<GamificationCubit, GamificationModel>(
      builder: (context, gamification) {
        return BlocBuilder<TaskCubitCubit, TaskCubitState>(
          builder: (context, taskState) {
            final tasks =
                taskState is TaskCubitLoaded ? taskState.tasks : <TaskModel>[];

            final now = DateTime.now();
            final todayTasks = tasks.where((task) {
              final d = task.deadlineDate;
              if (d == null) return false;
              return d.year == now.year &&
                  d.month == now.month &&
                  d.day == now.day;
            }).toList();

            final completedToday =
                todayTasks.where((t) => t.isCompleted).length;
            final highPriorityCount = tasks
                .where((t) => t.priority == TaskPriority.high && !t.isCompleted)
                .length;

            final messages = SupportiveMessagesProvider.getMessagesForContext(
              gamification: gamification,
              completedTasksToday: completedToday,
              totalTasksToday: todayTasks.length,
              highPriorityCount: highPriorityCount,
            );

            final activeMessageInfo = messages.isNotEmpty
                ? messages[_messageIndex % messages.length]
                : const BuddyMessageInfo(
                    message: "Okay, let's make this easy. One step! 🚀",
                    tag: "Focus Buddy",
                    moodEmoji: "🚀",
                    mood: BuddyMood.ready,
                  );

            return Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: isDark
                      ? [
                          const Color(0xFF261E3E),
                          const Color(0xFF1D1730),
                        ]
                      : [
                          const Color(0xFFF3EEFF),
                          const Color(0xFFE8DDFF),
                        ],
                ),
                borderRadius: BorderRadius.circular(22.r),
                border: Border.all(
                  color: isDark
                      ? const Color(0xFF4A3A73)
                      : const Color(0xFFD3C2F8),
                  width: 1.2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: primaryColor.withOpacity(isDark ? 0.12 : 0.08),
                    blurRadius: 18,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Interactive Avatar
                  GestureDetector(
                    onTap: () => _onBuddyTapped(messages.length),
                    child: AnimatedBuilder(
                      animation: _bounceController,
                      builder: (context, child) {
                        return Transform.translate(
                          offset: Offset(0, _breatheAnimation.value),
                          child: Transform.scale(
                            scale: _bounceController.isAnimating
                                ? (_bounceAnimation.value)
                                : 1.0,
                            child: child,
                          ),
                        );
                      },
                      child: Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.center,
                        children: [
                          // Glowing Aura Ring
                          Container(
                            width: 88.r,
                            height: 88.r,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: RadialGradient(
                                colors: [
                                  primaryColor.withOpacity(0.35),
                                  primaryColor.withOpacity(0.0),
                                ],
                              ),
                            ),
                          ),
                          // Mascot Image
                          Container(
                            width: 82.r,
                            height: 82.r,
                            padding: EdgeInsets.all(4.r),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isDark
                                  ? const Color(0xFF332754)
                                  : Colors.white,
                              border: Border.all(
                                color: const Color(0xFFFFD77B),
                                width: 2.2,
                              ),
                            ),
                            child: ClipOval(
                              child: Assets.images.repot.image(
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          // Energy / Mood Badge
                          Positioned(
                            bottom: -2,
                            right: -2,
                            child: Container(
                              padding: EdgeInsets.all(4.r),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFD77B),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: isDark
                                      ? const Color(0xFF1D1730)
                                      : Colors.white,
                                  width: 2,
                                ),
                              ),
                              child: Text(
                                activeMessageInfo.moodEmoji,
                                style: TextStyle(fontSize: 12.sp),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  16.horizontalSpace,

                  // Speech Bubble & Encouragement Card
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _onBuddyTapped(messages.length),
                      behavior: HitTestBehavior.opaque,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Tag & Reaction Hint
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8.w,
                                  vertical: 3.h,
                                ),
                                decoration: BoxDecoration(
                                  color: primaryColor.withOpacity(0.18),
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                child: Text(
                                  activeMessageInfo.tag,
                                  style: TextStyle(
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.bold,
                                    color: isDark
                                        ? const Color(0xFFC7B1FA)
                                        : const Color(0xFF5733A8),
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Text(
                                _recentReaction ?? 'Tap to chat 💬',
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w600,
                                  color: _recentReaction != null
                                      ? const Color(0xFFFFB300)
                                      : (isDark
                                          ? Colors.white54
                                          : const Color(0xFF756F86)),
                                ),
                              ),
                            ],
                          ),

                          8.verticalSpace,

                          // Main Message
                          Text(
                            activeMessageInfo.message,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                              height: 1.35,
                              color: isDark
                                  ? Colors.white
                                  : const Color(0xFF22173F),
                            ),
                          ),

                          6.verticalSpace,

                          // Small Subtitle / Context Note
                          Text(
                            gamification.streak > 0
                                ? 'Streak alive: ${gamification.streak} days 🔥 • +${gamification.dailyXp} XP today'
                                : 'Level ${gamification.level} • ${gamification.levelTitle}',
                            style: TextStyle(
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w500,
                              color: isDark
                                  ? Colors.white70
                                  : const Color(0xFF63567D),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
