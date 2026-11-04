import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:focus_flow/featue/Home/data/models/gamification_model.dart';
import 'package:focus_flow/featue/Home/data/repo/gamification_repo.dart';

class GamificationCubit
    extends Cubit<GamificationModel> {
  final GamificationRepository repository;

  GamificationCubit(this.repository)
      : super(repository.getData());

  Future<void> loadData() async {
    emit(repository.getData());
  }

  // +10 XP
  Future<void> rewardCompletedTask() async {
    final newData =
        await repository.completeTaskReward();

    emit(newData);
  }

  // -10 XP
  Future<void> undoCompletedTask() async {
    final newData =
        await repository.undoCompletedTask();

    emit(newData);
  }
}