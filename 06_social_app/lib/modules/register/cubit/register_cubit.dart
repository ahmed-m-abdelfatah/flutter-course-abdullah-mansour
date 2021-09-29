import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../models/user_model.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  // make object of the cubit
  static RegisterCubit get(context) => BlocProvider.of(context);

  // userRegister
  void userRegister({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    emit(RegisterLoading());

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // print('userRegister -- ${userCredential.user!.email}');
      // emit(RegisterSucess());

      userCreate(
        email: email,
        phone: phone,
        name: name,
        uId: userCredential.user!.uid,
      );
    } on FirebaseAuthException catch (error) {
      if (error.code == 'weak-password') {
        print('userRegister -- The password provided is too weak.');
        emit(RegisterError('The password is too weak.'));
      } else if (error.code == 'email-already-in-use') {
        print('userRegister -- The account already exists for that email.');
        emit(RegisterError('The account already exists'));
      }
    } catch (error) {
      print('userRegister -- ${error.toString()}');
      emit(RegisterError(error.toString()));
    }
  }

  // userCreate
  void userCreate({
    required String name,
    required String email,
    required String phone,
    required String uId,
  }) {
    UserModel currentUser = UserModel(
      email: email,
      name: name,
      phone: phone,
      uId: uId,
      emailVerified: false,
      image: 'https://image.flaticon.com/icons/png/512/3011/3011270.png',
      cover: 'http://unsplash.it/500/500?random&gravity=center',
      bio: 'write your bio ...',
    );

    FirebaseFirestore.instance
        .collection('users') // create new collection if not exist
        .doc(uId)
        .set(currentUser.toMap())
        .then(
      (value) {
        emit(CreateUserSucess(uId));
      },
    ).catchError((error) {
      print('userCreate -- ${error.toString()}');
      emit(CreateUserError(error.toString()));
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
