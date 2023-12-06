import 'package:flutter/material.dart';

import '../CustomViews/ButtonTextCustomizado.dart';
import '../CustomViews/EditTextCustomizado.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  late BuildContext _context;

  TextEditingController tecUsername = TextEditingController();
  TextEditingController tecPassword = TextEditingController();


  void onPressedRegistrar() {

  }

  void onPressedAceptar() async {

  }

  @override
  Widget build(BuildContext context) {
    _context = context;

    Column column = Column(
      children: [
        Image.asset("resources/MyLogo.png", height: 325, width: 325,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 16),
          child: EditTextCustomizado(tec: tecUsername, labelText: "Username (email)", blIsPassword: false),

        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 16),
          child: EditTextCustomizado(tec: tecPassword, labelText: "Password", blIsPassword: true),
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: ButtonTextCustomizado(buttonText: "ACEPTAR", onPressed: onPressedAceptar),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: ButtonTextCustomizado(buttonText: "REGISTRARSE", onPressed: onPressedRegistrar),
            ),
          ],
        ),
      ],
    );


    AppBar appBar = AppBar(
      title: const Text(
        "LOGIN",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      backgroundColor: const Color.fromRGBO(22, 36, 71, 1),
      automaticallyImplyLeading: false,
    );


    return Scaffold(
      body: column,
      appBar: appBar,
      backgroundColor: const Color.fromRGBO(31, 64, 104, 1),
    );
  }
}