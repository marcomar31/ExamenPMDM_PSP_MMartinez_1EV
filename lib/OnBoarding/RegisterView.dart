import 'package:flutter/material.dart';

import '../CustomViews/ButtonTextCustomizado.dart';
import '../CustomViews/EditTextCustomizado.dart';

class RegisterView extends StatelessWidget {
  RegisterView({Key? key});

  late BuildContext _context;

  TextEditingController tecUsername = TextEditingController();
  TextEditingController tecName = TextEditingController();
  TextEditingController tecPassword = TextEditingController();
  TextEditingController tecRepassword = TextEditingController();

  void onPressedAceptar() {

  }

  void onPressedCancelar() {
    Navigator.of(_context).popAndPushNamed("/login_view");
  }

  @override
  Widget build(BuildContext context) {
    _context = context;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "REGISTER",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(22, 36, 71, 1),
        automaticallyImplyLeading: false,
      ),
      backgroundColor: const Color.fromRGBO(31, 64, 104, 1),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset("resources/MyLogo.png", height: 325, width: 325,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 16),
              child: EditTextCustomizado(tec: tecUsername, labelText: "Username (email)", blIsPassword: false),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 16),
              child: EditTextCustomizado(tec: tecName, labelText: "Nombre", blIsPassword: false),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 16),
              child: EditTextCustomizado(tec: tecPassword, labelText: "Password", blIsPassword: true),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 16),
              child: EditTextCustomizado(tec: tecRepassword, labelText: "Repassword", blIsPassword: true),
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
                  child: ButtonTextCustomizado(buttonText: "CANCELAR", onPressed: onPressedCancelar),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
