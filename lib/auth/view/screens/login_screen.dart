import 'package:chat_app/shared/app_validator.dart';
import 'package:chat_app/auth/view/widgets/default_elevated_boutton.dart';
import 'package:chat_app/auth/view/widgets/default_login_and_register_text_form_fieled.dart';
import 'package:chat_app/auth/view_model/auth_state.dart';
import 'package:chat_app/auth/view_model/auth_view_model.dart';
import 'package:chat_app/shared/ui_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login',
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
                const SizedBox(height: 20),
                DefaultLoginAndRegisterTextFormFieled(
                  label: 'Email',
                  controller: emailcontroller,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email can not be empty';
                    } else if (!AppValidator.isEmailValid(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                DefaultLoginAndRegisterTextFormFieled(
                  label: 'Password',
                  controller: passwordcontroller,
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
                  listener: (_, state) {
                    if (state is LoginLoading) {
                      UiUtils.showLoading(context);
                    } else if (state is LoginSuccess) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        Navigator.of(context).pushReplacementNamed('/home');
                      });
                    } else if (state is LoginError) {
                      UiUtils.hideLoading(context);
                      UiUtils.showSnackBar(context, state.message);
                    }
                  },
                  child: DefaultElevatedBoutton(
                    text: "Login",
                    onPressed: login,
                  ),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed('/register');
                  },
                  child: Text(
                    'Dont have an account?',
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

  void login() async {
    if (formkey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      BlocProvider.of<AuthViewModel>(context).loginUser(
        email: emailcontroller.text,
        password: passwordcontroller.text,
      );
    }
  }
}
