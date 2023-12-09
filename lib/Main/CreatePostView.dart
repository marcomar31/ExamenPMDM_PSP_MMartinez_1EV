import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../CustomViews/ButtonTextCustomizado.dart';
import '../CustomViews/EditTextCustomizado.dart';
import '../FirestoreObjects/FbPost.dart';
import '../Singletone/DataHolder.dart';

class CreatePostView extends StatefulWidget{
  const CreatePostView({super.key});

  @override
  State<CreatePostView> createState() => _CreatePostViewState();
}

class _CreatePostViewState extends State<CreatePostView> {
  FirebaseFirestore firebaseFirestore = DataHolder().db;

  TextEditingController tecTitulo = TextEditingController();
  TextEditingController tecCuerpo = TextEditingController();

  void subirPost() async {
    FbPost postNuevo = FbPost(
        titulo: tecTitulo.text,
        cuerpo: tecCuerpo.text,
        sUrlImage: "");
    DataHolder().fbAdmin.subirNuevoPost(firebaseFirestore, postNuevo);
  }

  void onPressedSubir() async {
    if (tecTitulo.text.isNotEmpty && tecCuerpo.text.isNotEmpty) {
      subirPost();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Se ha subido el post exitosamente")));
      Navigator.pop(context, true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Todos los campos deben estar rellenos")));
    }
  }

  void onPressedCancelar() {
    Navigator.of(context).pop(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "SUBIR POST",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromRGBO(22, 36, 71, 1),
      ),      body: Column(
        children: [
          Padding(padding: const EdgeInsets.only(top: 20), child:
          Container(width: 300, height: 300, color: const Color.fromRGBO(228, 63, 90, 1), child:
            const Padding(padding: EdgeInsets.all(16.0), child:
              Align(alignment: Alignment.center, child:
                Text("Actualmente no se pueden crear posts con imagen"),
              ),
            ),
          ),
          ),
          const SizedBox(height: 30,),
          Padding(padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 16),
              child: EditTextCustomizado(tec: tecTitulo, labelText: "Título")
          ),
          Padding(padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 16),
              child: EditTextCustomizado(tec: tecCuerpo, labelText: "Cuerpo")
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: ButtonTextCustomizado(buttonText: "PUBLICAR", onPressed: onPressedSubir),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: ButtonTextCustomizado(buttonText: "CANCELAR", onPressed: onPressedCancelar),
              ),
            ],
          )
        ],
      ),
      backgroundColor: const Color.fromRGBO(31, 64, 104, 1),
    );
  }
}