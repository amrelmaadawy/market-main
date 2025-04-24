part of 'loginstate_cubit.dart';

abstract class LoginstateState {}

class LoginstateInitial extends LoginstateState {}

class LoginstateLoading extends LoginstateState {}

class LoginstateSuccesses extends LoginstateState {}

class LoginstateErorr extends LoginstateState {
  final String message;
  LoginstateErorr(this.message);
}

class IsvisibleState extends LoginstateState {}

class SignUpstateLoading extends LoginstateState {}

class SignUpstateSuccesses extends LoginstateState {}

class SignUpstateErorr extends LoginstateState {
  final String message;
  SignUpstateErorr(this.message);
}

class GoogleSignInLoading extends LoginstateState {}

class GoogleSignInSuccesses extends LoginstateState {}

class GoogleSignInErorr extends LoginstateState {
  final String message;
  GoogleSignInErorr(this.message);
}

class LogoutLoading extends LoginstateState {}

class LogoutSuccesses extends LoginstateState {}

class LogoutErorr extends LoginstateState {
  final String message;
  LogoutErorr(this.message);
}

class ResetPasswordLoading extends LoginstateState {}

class ResetPasswordSuccesses extends LoginstateState {}

class ResetPasswordErorr extends LoginstateState {
  final String message;
  ResetPasswordErorr(this.message);
}

class AddUsersLoading extends LoginstateState {}

class AddUsersSuccesses extends LoginstateState {}

class AddUsersErorr extends LoginstateState {
  final String message;
  AddUsersErorr(this.message);
}

class GetDataLoading extends LoginstateState {}

class GetDataSuccesses extends LoginstateState {}

class GetDataErorr extends LoginstateState {
  final String message;
  GetDataErorr(this.message);
}
