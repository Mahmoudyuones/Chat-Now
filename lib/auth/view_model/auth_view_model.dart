import 'package:chat_app/auth/view_model/auth_state.dart';
import 'package:chat_app/shared/firebasefunctions.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthViewModel extends Cubit<AuthState> {
  AuthViewModel() : super(AuthInitial());
  UserModel? currentUser;
  Future<void> registerUser({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(RegisterLoading());
    try {
      currentUser = await Firebasefunctions.register(
        name: name,
        email: email,
        password: password,
      );
      emit(RegisterSuccess());
    } catch (e) {
      emit(RegisterError(e.toString()));
    }
  }

  Future<void> loginUser({
    required String email,
    required String password,
  }) async {
    emit(LoginLoading());
    try {
      currentUser = await Firebasefunctions.login(
        email: email,
        password: password,
      );
      emit(LoginSuccess());
    } catch (e) {
      emit(LoginError(e.toString()));
    }
  }

  Future<void> logoutUser() async {
    emit(LogoutLoading());
    try {
      await Firebasefunctions.signOut();
      currentUser = null;
      emit(LogoutSuccess());
      currentUser = null;
    } catch (e) {
      emit(LogoutError(e.toString()));
    }
  }
}
