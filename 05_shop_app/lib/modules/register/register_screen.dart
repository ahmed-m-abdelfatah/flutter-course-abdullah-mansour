import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'cubit/register_cubit.dart';
import '../../shared/network/local/cache_data.dart';
import '../../app_router.dart';
import '../../shared/components/components.dart';
import '../../shared/network/local/cache_helper.dart';
import '../../shared/styles/my_main_styles.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextEditingController _nameController = TextEditingController();
    TextEditingController _emailController = TextEditingController();
    TextEditingController _phoneController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();

    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is RegisterSucess) {
            if (state.registerModel.status) {
              _goToHomeScreen(state, context);
            } else {
              showToast(
                state: ToastStates.ERROR,
                text: state.registerModel.message,
              );
            }
          }
        },
        builder: (context, state) {
          RegisterCubit _registerCubit = RegisterCubit.get(context);

          return Scaffold(
            appBar: AppBar(),
            body: _buildBody(
              context: context,
              state: state,
              registerCubit: _registerCubit,
              nameController: _nameController,
              emailController: _emailController,
              phoneController: _phoneController,
              passwordController: _passwordController,
            ),
          );
        },
      ),
    );
  }

  Center _buildBody({
    required BuildContext context,
    required RegisterState state,
    required RegisterCubit registerCubit,
    required TextEditingController nameController,
    required TextEditingController emailController,
    required TextEditingController phoneController,
    required TextEditingController passwordController,
  }) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'REGISTER',
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                        color: MyMainColors.myBlack,
                      ),
                ),
                Text(
                  'Register now to browse our offers',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: Colors.grey,
                      ),
                ),
                const SizedBox(height: 30),
                defaultFormField(
                  controller: nameController,
                  type: TextInputType.name,
                  validate: (String? value) {
                    if (value!.isEmpty) {
                      return 'Please Enter Your Name';
                    }
                  },
                  label: 'Name',
                  prefix: Icons.person,
                ),
                const SizedBox(height: 15),
                defaultFormField(
                  controller: emailController,
                  type: TextInputType.emailAddress,
                  validate: (String? value) {
                    if (value!.isEmpty) {
                      return 'Please Enter Your Email Adress';
                    }
                  },
                  label: 'Email Adress',
                  prefix: Icons.email_outlined,
                ),
                const SizedBox(height: 15),
                defaultFormField(
                  controller: phoneController,
                  type: TextInputType.phone,
                  validate: (String? value) {
                    if (value!.isEmpty) {
                      return 'Please Enter Your Phone';
                    }
                  },
                  label: 'Phone',
                  prefix: Icons.phone,
                ),
                const SizedBox(height: 15),
                defaultFormField(
                  controller: passwordController,
                  type: TextInputType.visiblePassword,
                  isPassword: registerCubit.isPassword,
                  suffix: registerCubit.suffix,
                  suffixPressed: () {
                    registerCubit.changePasswordVisibality();
                  },
                  validate: (String? value) {
                    if (value!.isEmpty) {
                      return 'Please Enter Your Password';
                    }
                  },
                  onSubmit: (_) {
                    _registerAuthorization(
                      context: context,
                      registerCubit: registerCubit,
                      nameController: nameController,
                      emailController: emailController,
                      phoneController: phoneController,
                      passwordController: passwordController,
                    );
                  },
                  label: 'Password',
                  prefix: Icons.lock_outline,
                ),
                const SizedBox(height: 30),
                Conditional.single(
                  context: context,
                  conditionBuilder: (BuildContext context) {
                    return state is! RegisterLoading;
                  },
                  widgetBuilder: (BuildContext context) {
                    return defaultButton(
                      onPressedFunction: () {
                        _registerAuthorization(
                          context: context,
                          registerCubit: registerCubit,
                          nameController: nameController,
                          emailController: emailController,
                          phoneController: phoneController,
                          passwordController: passwordController,
                        );
                      },
                      text: 'Register',
                    );
                  },
                  fallbackBuilder: (BuildContext context) {
                    return Center(child: CircularProgressIndicator());
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _registerAuthorization({
    required BuildContext context,
    required RegisterCubit registerCubit,
    required TextEditingController nameController,
    required TextEditingController emailController,
    required TextEditingController phoneController,
    required TextEditingController passwordController,
  }) {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      registerCubit.userRegister(
        name: nameController.text,
        email: emailController.text,
        phone: phoneController.text,
        password: passwordController.text,
      );
    }
  }

  void _goToHomeScreen(RegisterSucess state, BuildContext context) {
    CacheHelper.saveCacheData(
            key: 'token', value: state.registerModel.data!.token)
        .then((_) {
      token = state.registerModel.data!.token;
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRouter.homeLayoutScreen,
        (route) => false,
      );
    });
  }
}
