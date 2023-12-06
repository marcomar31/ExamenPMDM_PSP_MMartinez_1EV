import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(31, 64, 104, 1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(30),
            child: Image.asset("resources/MyLogo.png", height: 400, width: 400,),
          ),
          const SizedBox(height: 30),
          const CircularProgressIndicator(),
        ],
      ),
    );
  }

}