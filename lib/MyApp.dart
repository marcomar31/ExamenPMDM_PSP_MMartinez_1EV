import 'package:flutter/material.dart';

import 'OnBoarding/LoginView.dart';
import 'OnBoarding/RegisterView.dart';
import 'OnBoarding/SplashView.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: "KytY Miau Web!",
      routes: {
        '/splash_view': (context) => const SplashView(),
        '/login_view': (context) => LoginView(),
        '/register_view': (context) => RegisterView(),
      },
      initialRoute: '/splash_view',
    );
  }
}