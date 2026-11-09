import 'package:bloc/bloc.dart';
import 'package:focus_flow/featue/Authentication/data/repo/login_repo.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
   Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(LoginLoading());

    try {
      final response = await AuthRepo.Login(
        email: email,
        password: password,
      );

      if (response) {
        emit(LoginSuccess());
      } else {
        emit(LoginSuccess());
      }
    } catch (e) {
      emit(LoginError());
    }
  }

}
