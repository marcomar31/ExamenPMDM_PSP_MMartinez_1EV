import 'package:flutter/material.dart';

class EditTextCustomizado extends StatelessWidget {

  String labelText;
  TextEditingController tec;
  bool blIsPassword;

  EditTextCustomizado({super.key,
    this.labelText="",
    required this.tec,
    this.blIsPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 400.0),
      child: TextFormField(
        controller: tec,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: const BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: const BorderSide(color: Color.fromRGBO(22, 36, 71, 1)),
          ),
          labelText: labelText,
          labelStyle: const TextStyle(color: Colors.white),
        ),
        cursorColor: const Color.fromRGBO(22, 36, 71, 1),
        obscureText: blIsPassword,
      ),
    );
  }

}