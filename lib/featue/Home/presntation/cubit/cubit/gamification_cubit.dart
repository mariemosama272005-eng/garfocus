import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_flow/featue/Home/data/models/gamification_model.dart';
import 'package:focus_flow/featue/Home/data/repo/gamification_repo.dart';

class GamificationCubit extends Cubit<GamificationModel> {
  final GamificationRepository _repository;

  GamificationCubit(this._repository) : super(_repository.getData());

  /// تحميل بيانات الـ Gamification الحالية
  Future<void> loadData() async {
    try {
      final data = _repository.getData();
      emit(data);
    } catch (e) {
      // التعامل مع الخطأ بصمت أو طباعته
    }
  }

  /// منح مكافأة إتمام المهمة (+XP & Level update)
  Future<void> rewardCompletedTask() async {
    try {
      final newData = await _repository.completeTaskReward();
      emit(newData);
    } catch (e) {
      // التعامل مع الخطأ
    }
  }

  /// إلغاء مكافأة المهمة عند العودة للحالة المعلقة (-XP)
  Future<void> undoCompletedTask() async {
    try {
      final newData = await _repository.undoCompletedTask();
      emit(newData);
    } catch (e) {
      // التعامل مع الخطأ
    }
  }
}