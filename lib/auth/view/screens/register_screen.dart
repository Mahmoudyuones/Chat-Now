import 'package:chat_app/shared/app_validator.dart';
import 'package:chat_app/auth/view_model/auth_state.dart';
import 'package:chat_app/auth/view_model/auth_view_model.dart';
import 'package:chat_app/auth/view/widgets/default_elevated_boutton.dart';
import 'package:chat_app/auth/view/widgets/default_login_and_register_text_form_fieled.dart';
import 'package:chat_app/shared/ui_utils.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = '/register';
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Register',
          style: Theme.of(
            context,
          ).textTheme.titleMedium!.copyWith(fontSize: 25),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DefaultLoginAndRegisterTextFormFieled(
                  label: 'Name',
                  controller: nameController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please Enter the Name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                DefaultLoginAndRegisterTextFormFieled(
                  label: 'Email',
                  controller: emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter the Email';
                    } else if (!AppValidator.isEmailValid(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                DefaultLoginAndRegisterTextFormFieled(
                  label: 'Password',
                  controller: passwordController,
                  validator: (value) {
                    if (value == null || value.trim().length < 8) {
                      return 'Password can not be less than 8 charactar';
                    }
                    return null;
                  },
                  isPassword: true,
                ),
                const SizedBox(height: 20),
                BlocListener<AuthViewModel, AuthState>(
                  listener: (context, state) {
                    if (state is RegisterLoading) {
                      UiUtils.showLoading(context);
                    } else if (state is RegisterError) {
                      UiUtils.hideLoading(context);
                      UiUtils.showSnackBar(context, state.message);
                    } else if (state is RegisterSuccess) {
                      UiUtils.hideLoading(context);
                      Navigator.of(context).pushReplacementNamed('/home');
                    }
                  },
                  child: DefaultElevatedBoutton(
                    text: "Register",
                    onPressed: register,
                  ),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed('/login');
                  },
                  child: Text(
                    'Allready have an account? Login',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void register() {
    if (formkey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      BlocProvider.of<AuthViewModel>(context).registerUser(
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    }
  }
}
