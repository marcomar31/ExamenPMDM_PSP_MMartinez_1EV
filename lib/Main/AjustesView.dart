import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:examenpmdm_pap_mmartinez_1ev/Singletone/DataHolder.dart';
import 'package:flutter/material.dart';

import '../CustomViews/ButtomBarCustomizado.dart';
import '../CustomViews/DrawerCustomizado.dart';
import '../CustomViews/PostsGridView.dart';
import '../CustomViews/PostsListView.dart';
import '../FirestoreObjects/FbPost.dart';

class AjustesView extends StatefulWidget {
  const AjustesView({super.key});

  @override
  _AjustesViewState createState() => _AjustesViewState();
}

class _AjustesViewState extends State<AjustesView> {
  FirebaseFirestore db = FirebaseFirestore.instance;

  void onPressedDrawer(int indice){
    if (indice == 0) {
      Navigator.of(context).popAndPushNamed("/home_view");
    } else if(indice == 1){
      Navigator.of(context).popAndPushNamed("/ajustes_view");
    } else if(indice == 2){
      DataHolder().fbAdmin.logOutUsuario();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Se ha cerrado la sesión correctamente")));
      Navigator.of(context).popAndPushNamed("/login_view");
    }
  }

  @override
  void initState() {
    super.initState();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "AJUSTES",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color.fromRGBO(22, 36, 71, 1),
      ),
      drawer: DrawerCustomizado(onItemTap: onPressedDrawer),
      backgroundColor: const Color.fromRGBO(31, 64, 104, 1),
    );
  }
}