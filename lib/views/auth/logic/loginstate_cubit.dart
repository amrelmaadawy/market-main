import 'package:app/views/auth/logic/module/user_module.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'loginstate_state.dart';

class LoginstateCubit extends Cubit<LoginstateState> {
  LoginstateCubit() : super(LoginstateInitial());

  bool isVisible = true;
  void changeVisibility() {
    isVisible = !isVisible;
    emit(IsvisibleState());
  }

  SupabaseClient client = Supabase.instance.client;

  Future<void> login({required String email, required String password}) async {
    emit(LoginstateLoading());
    try {
      await client.auth.signInWithPassword(password: password, email: email);
      await getData();
      emit(LoginstateSuccesses());
    } on AuthApiException catch (e) {
      emit(LoginstateErorr(e.message));
      if (kDebugMode) {
        print(e.toString());
      }
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
      await client.auth.signUp(password: password, email: email);
      await addUsersInDataBase(email: email, name: name);
      await getData();
      emit(SignUpstateSuccesses());
    } on AuthApiException catch (e) {
      emit(SignUpstateErorr(e.message));
      if (kDebugMode) {
        print(e.toString());
      }
    } catch (e) {
      emit(SignUpstateErorr(e.toString()));
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  Future<AuthResponse> nativeGoogleSignIn() async {
    emit(GoogleSignInLoading());
    const webClientId =
        '864504745026-ab65m32m56ppmh4p86jop400s96kqn4f.apps.googleusercontent.com';

    final GoogleSignIn googleSignIn = GoogleSignIn(
      serverClientId: webClientId,
    );
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) {
      emit(GoogleSignInErorr('Google Sign In Failed'));
      return AuthResponse();
    }
    final googleAuth = await googleUser.authentication;
    final accessToken = googleAuth.accessToken;
    final idToken = googleAuth.idToken;

    if (accessToken == null || idToken == null) {
      emit(GoogleSignInErorr('Google Sign In Failed'));
      return AuthResponse();
    }

    AuthResponse response = await client.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: accessToken,
    );
    await addUsersInDataBase(
      name: googleUser.displayName!,
      email: googleUser.email,
    );
    await getData();
    emit(GoogleSignInSuccesses());
    return response;
  }

  Future<void> logOUt() async {
    emit(LogoutLoading());
    try {
      await client.auth.signOut();
      emit(LogoutSuccesses());
    } catch (e) {
      emit(LogoutErorr(e.toString()));
    }
  }

  Future<void> resePassword({required String email}) async {
    emit(ResetPasswordLoading());
    try {
      await client.auth.resetPasswordForEmail(email);
      emit(ResetPasswordSuccesses());
    } catch (e) {
      emit(ResetPasswordErorr(e.toString()));
    }
  }

  Future<void> addUsersInDataBase(
      {required String name, required String email}) async {
    emit(AddUsersLoading());
    try {
      await client.from('Users').upsert({
        'name': name,
        'email': email,
        'id': client.auth.currentUser!.id,
      });
      emit(AddUsersSuccesses());
    } catch (e) {
      emit(AddUsersErorr(e.toString()));
    }
  }

  UserModule? userModule;
  Future<void> getData() async {
    emit(GetDataLoading());
    try {
      final data = await client
          .from('Users')
          .select()
          .eq('id', client.auth.currentUser!.id);
      userModule = UserModule(
          email: data[0]['email'], id: data[0]['id'], name: data[0]['name']);
      if (kDebugMode) {
        print(data);
      }
      emit(GetDataSuccesses());
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
        print("===========================================");
      }
      emit(GetDataErorr(e.toString()));
    }
  }
}
