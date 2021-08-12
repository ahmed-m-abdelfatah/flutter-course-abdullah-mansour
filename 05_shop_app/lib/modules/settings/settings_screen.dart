import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import '../../layout/cubit/shop_cubit.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {
        // Error because states change fast
        // if (state is SuccessUserData) {
        //   _nameController.text = state.userData.data!.name;
        //   _emailController.text = state.userData.data!.email;
        //   _phoneController.text = state.userData.data!.phone;
        // }
      },
      builder: (context, state) {
        var _model = ShopCubit.get(context).userModel;
        _nameController.text = _model!.data!.name;
        _emailController.text = _model.data!.email;
        _phoneController.text = _model.data!.phone;

        return Conditional.single(
          context: context,
          conditionBuilder: (context) => _conditionBuilder(context, state),
          widgetBuilder: (context) => _widgetBuilder(context, state),
          fallbackBuilder: _fallbackBuilder,
        );
      },
    );
  }

  bool _conditionBuilder(BuildContext context, state) {
    return ShopCubit.get(context).userModel != null;
  }

  Widget _widgetBuilder(context, state) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              if (state is LoadingUpdateUserData) LinearProgressIndicator(),
              const SizedBox(height: 20.0),
              defaultFormField(
                controller: _nameController,
                type: TextInputType.name,
                validate: (String? val) {
                  if (val!.isEmpty) return 'name must not be empty';
                },
                label: 'Name',
                prefix: Icons.person,
              ),
              const SizedBox(height: 20.0),
              defaultFormField(
                controller: _emailController,
                type: TextInputType.emailAddress,
                validate: (String? val) {
                  if (val!.isEmpty) return 'email must not be empty';
                },
                label: 'Email',
                prefix: Icons.email,
              ),
              const SizedBox(height: 20.0),
              defaultFormField(
                controller: _phoneController,
                type: TextInputType.phone,
                validate: (String? val) {
                  if (val!.isEmpty) return 'phone must not be empty';
                },
                label: 'Phone',
                prefix: Icons.phone,
              ),
              const SizedBox(height: 20.0),
              defaultButton(
                onPressedFunction: () {
                  // chect no empty value
                  if (_formKey.currentState!.validate()) {
                    // to close keypord if open
                    FocusScope.of(context).unfocus();

                    ShopCubit.get(context).updateUserData(
                      name: _nameController.text,
                      email: _emailController.text,
                      phone: _phoneController.text,
                    );
                  }
                },
                text: 'update',
              ),
              const SizedBox(height: 20.0),
              defaultButton(
                onPressedFunction: () => signOut(context),
                text: 'logout',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _fallbackBuilder(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
