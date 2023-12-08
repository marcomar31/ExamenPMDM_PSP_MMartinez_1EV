import 'package:flutter/material.dart';


class ButtomBarCustomizado extends StatelessWidget{

  Function(int indice)? onBotonesClicked;

  ButtomBarCustomizado({super.key,required this.onBotonesClicked
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //throw UnimplementedError();
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton(onPressed: () => onBotonesClicked!(0), child: const Icon(Icons.list, color: Colors.white,)),
          TextButton(onPressed: () => onBotonesClicked!(1), child: const Icon(Icons.grid_view, color: Colors.white,)),
        ]
    );
  }
}