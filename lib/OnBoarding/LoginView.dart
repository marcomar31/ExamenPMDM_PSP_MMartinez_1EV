import 'package:flutter/material.dart';

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
          child: TextField(
            controller: tecUsername,
            style: const TextStyle(color: Colors.white), // Color del texto blanco
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Username',
              labelStyle: TextStyle(color: Colors.white), // Color del texto de la etiqueta blanco
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 16),
          child: TextFormField(
            controller: tecPassword,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Password',
              labelStyle: TextStyle(color: Colors.white),
            ),
            obscureText: true,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: TextButton(
                onPressed: onPressedAceptar,
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                ),
                child: const Text("ACEPTAR"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: TextButton(
                onPressed: onPressedRegistrar,
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                ),
                child: const Text("REGISTRO"),
              ),
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
      shadowColor: Colors.blue,
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