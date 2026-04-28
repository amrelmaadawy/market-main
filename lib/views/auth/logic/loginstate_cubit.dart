import 'package:app/views/auth/logic/module/user_module.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

part 'loginstate_state.dart';

class LoginstateCubit extends Cubit<LoginstateState> {
  LoginstateCubit() : super(LoginstateInitial());

  bool isVisible = true;
  bool isLoggedIn = false;
  UserModule? userModule;

  void changeVisibility() {
    isVisible = !isVisible;
    emit(IsvisibleState());
  }

  Future<void> login({required String email, required String password}) async {
    emit(LoginstateLoading());
    try {
      await Future.delayed(const Duration(seconds: 1));
      userModule = UserModule(email: email, id: 'dummy_user_123', name: 'Mock User');
      isLoggedIn = true;
      emit(LoginstateSuccesses());
    } catch (e) {
      emit(LoginstateErorr(e.toString()));
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  Future<void> register(
      {required String email,
      required String password,
      required String name}) async {
    emit(SignUpstateLoading());
    try {
      await Future.delayed(const Duration(seconds: 1));
      userModule = UserModule(email: email, id: 'dummy_user_123', name: name);
      isLoggedIn = true;
      emit(SignUpstateSuccesses());
    } catch (e) {
      emit(SignUpstateErorr(e.toString()));
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  Future<void> nativeGoogleSignIn() async {
    emit(GoogleSignInLoading());
    try {
      await Future.delayed(const Duration(seconds: 1));
      userModule = UserModule(email: 'google@example.com', id: 'dummy_user_123', name: 'Google User');
      isLoggedIn = true;
      emit(GoogleSignInSuccesses());
    } catch (e) {
      emit(GoogleSignInErorr('Google Sign In Failed'));
    }
  }

  Future<void> logOUt() async {
    emit(LogoutLoading());
    try {
      await Future.delayed(const Duration(seconds: 1));
      isLoggedIn = false;
      userModule = null;
      emit(LogoutSuccesses());
    } catch (e) {
      emit(LogoutErorr(e.toString()));
    }
  }

  Future<void> resePassword({required String email}) async {
    emit(ResetPasswordLoading());
    try {
      await Future.delayed(const Duration(seconds: 1));
      emit(ResetPasswordSuccesses());
    } catch (e) {
      emit(ResetPasswordErorr(e.toString()));
    }
  }

  Future<void> addUsersInDataBase(
      {required String name, required String email}) async {
    emit(AddUsersLoading());
    try {
      await Future.delayed(const Duration(seconds: 1));
      emit(AddUsersSuccesses());
    } catch (e) {
      emit(AddUsersErorr(e.toString()));
    }
  }

  Future<void> getData() async {
    emit(GetDataLoading());
    try {
      await Future.delayed(const Duration(seconds: 1));
      userModule ??= UserModule(email: 'test@test.com', id: 'dummy_user_123', name: 'Test User');
      emit(GetDataSuccesses());
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      emit(GetDataErorr(e.toString()));
    }
  }

  Future<void> editName({required String name}) async {
    emit(EditNameLoading());
    try {
      await Future.delayed(const Duration(seconds: 1));
      if (userModule != null) {
        userModule = UserModule(email: userModule!.email, id: userModule!.id, name: name);
      }
      emit(EditNameSuccesses()); 
    } catch (e) {
      emit(EditNameErorr()); 
    }
  }
}
