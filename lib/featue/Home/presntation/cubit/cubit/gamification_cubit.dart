import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_flow/featue/Home/data/models/gamification_model.dart';
import 'package:focus_flow/featue/Home/data/repo/gamification_repo.dart';

class GamificationCubit extends Cubit<GamificationModel> {
  final GamificationRepository _repository;

  GamificationCubit(this._repository) : super(_repository.getData());

  /// Load current Gamification data from local storage
  Future<void> loadData() async {
    try {
      final data = _repository.getData();
      emit(data);
    } catch (e) {
      // Handle error silently
    }
  }

  /// Award task completion (+10 XP, streak, achievements)
  Future<void> rewardCompletedTask() async {
    try {
      final newData = await _repository.completeTaskReward();
      emit(newData);
    } catch (e) {
      // Handle error silently
    }
  }

  /// Undo task completion (-10 XP)
  Future<void> undoCompletedTask() async {
    try {
      final newData = await _repository.undoCompletedTask();
      emit(newData);
    } catch (e) {
      // Handle error silently
    }
  }

  /// Award focus session completion (+15 XP, focus minutes, streak, achievements)
  Future<void> rewardCompletedFocusSession({int minutes = 25}) async {
    try {
      final newData =
          await _repository.rewardCompletedFocusSession(minutes: minutes);
      emit(newData);
    } catch (e) {
      // Handle error silently
    }
  }
}
