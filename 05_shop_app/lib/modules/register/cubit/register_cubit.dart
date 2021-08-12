import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import '../../../models/login_model.dart';
import '../../../shared/network/remote/dio_helper.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  // make object of the cubit
  static RegisterCubit get(context) => BlocProvider.of(context);
  late LoginModel _registerModel;

  void userRegister({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) {
    emit(RegisterLoading());

    DioHelper.postData(
      path: ApiDataAndEndPoints.registerPathUrl,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
        'password': password,
      },
    ).then((value) {
      _registerModel = LoginModel.fromJson(value.data);
      print('STATUS ${_registerModel.status}');
      emit(RegisterSucess(_registerModel));
    }).catchError((errorMessage) {
      print(errorMessage.toString());
      emit(RegisterError(errorMessage.toString()));
    });
  }

// password text field
  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibality() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(ChangePasswordVisibality());
  }
}
