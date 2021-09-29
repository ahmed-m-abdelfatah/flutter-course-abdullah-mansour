part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSucess extends LoginState {
  final String uId;
  LoginSucess(this.uId);
}

class LoginError extends LoginState {
  final String error;

  LoginError(this.error);
}

class ChangePasswordVisibality extends LoginState {}
