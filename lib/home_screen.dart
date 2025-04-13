import 'package:chat_app/auth/view/screens/login_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/home';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home',
          style: Theme.of(
            context,
          ).textTheme.titleMedium!.copyWith(fontSize: 25),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              'Welcome to the Home Screen!',
              style: Theme.of(
                context,
              ).textTheme.titleMedium!.copyWith(fontSize: 20),
            ),
            ElevatedButton(
              onPressed:
                  () => Navigator.of(
                    context,
                  ).pushReplacementNamed(LoginScreen.routeName),
              child: Text('back to login'),
            ),
          ],
        ),
      ),
    );
  }
}
