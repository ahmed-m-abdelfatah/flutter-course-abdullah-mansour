part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSucess extends LoginState {
  final LoginModel loginModel;

  LoginSucess(this.loginModel);
}

class LoginError extends LoginState {
  final String errorMessage;

  LoginError(this.errorMessage);
}

class ChangePasswordVisibality extends LoginState {}
