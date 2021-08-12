part of 'register_cubit.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSucess extends RegisterState {
  final LoginModel registerModel;

  RegisterSucess(this.registerModel);
}

class RegisterError extends RegisterState {
  final String errorMessage;

  RegisterError(this.errorMessage);
}

class ChangePasswordVisibality extends RegisterState {}
