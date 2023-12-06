import 'package:flutter/material.dart';

class ButtonTextCustomizado extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;

  const ButtonTextCustomizado({
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: const Color.fromRGBO(22, 36, 71, 1),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
      child: Text(buttonText),
    );
  }
}
