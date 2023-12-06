import 'package:flutter/material.dart';

import 'Main/HomeView.dart';
import 'OnBoarding/LoginView.dart';
import 'OnBoarding/RegisterView.dart';
import 'OnBoarding/SplashView.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: "Examen Marco 1Ev",
      routes: {
        '/splash_view': (context) => const SplashView(),
        '/login_view': (context) => LoginView(),
        '/register_view': (context) => RegisterView(),
        '/home_view': (context) => const HomeView(),
      },
      initialRoute: '/splash_view',
    );
  }
}