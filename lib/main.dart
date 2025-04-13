import 'package:chat_app/shared/appthem.dart';
import 'package:chat_app/auth/view/screens/login_screen.dart';
import 'package:chat_app/auth/view/screens/register_screen.dart';
import 'package:chat_app/auth/view_model/auth_view_model.dart';
import 'package:chat_app/shared/firebase_options.dart';
import 'package:chat_app/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    BlocProvider(create: (context) => AuthViewModel(), child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        LoginScreen.routeName: (context) => LoginScreen(),
        HomeScreen.routeName: (context) => HomeScreen(),
        RegisterScreen.routeName: (context) => RegisterScreen(),
      },
      initialRoute: LoginScreen.routeName,
      themeMode: ThemeMode.light,
      theme: Appthem.lighappthem,
    );
  }
}
