import 'package:flutter/material.dart';

import 'OnBoarding/LoginView.dart';
import 'OnBoarding/SplashView.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: "KytY Miau Web!",
      routes: {
        '/splash_view': (context) => const SplashView(),
        '/login_view': (context) => LoginView(),
      },
      initialRoute: '/login_view',
    );
  }
}