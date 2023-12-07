import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:examenpmdm_pap_mmartinez_1ev/Singletone/DataHolder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../FirestoreObjects/FbPost.dart';
import '../FirestoreObjects/FbProfile.dart';

class FirebaseAdmin {
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<bool> registerUsuario(String emailAddress, String password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      return true;
    } catch (e) {
      print('Error al registrar usuario: $e');
      return false;
    }
  }

  Future<bool> logInUsuario(String emailAddress, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      return true;
    } catch (e) {
      print('Error al iniciar sesión: $e');
      return false;
    }
  }


  Future<void> logOutUsuario() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<void> actualizarPerfilUsuario(FirebaseFirestore db, FbProfile perfil) async{
    String uidUsuario = FirebaseAuth.instance.currentUser?.uid ?? '';
    if (uidUsuario.isNotEmpty) {
      await db.collection("Usuarios").doc(uidUsuario).set(perfil.toFirestore());
    } else {
      print('Error: El UID del usuario actual está vacío.');
    }
  }

  Future<void> descargarPosts(FirebaseFirestore db, BuildContext context) async {
    CollectionReference<FbPost> ref = db.collection("Posts")
        .withConverter(fromFirestore: FbPost.fromFirestore, toFirestore: (FbPost post, _) => post.toFirestore());

    ref.snapshots().listen((postsDescargados) {
      print("NUMERO DE POSTS ACTUALIZADOS>>>> ${postsDescargados.docChanges.length}");
      DataHolder().listaPosts.clear();
      for (int i = 0; i < postsDescargados.docChanges.length; i++) {
        FbPost temp = postsDescargados.docChanges[i].doc.data()!;
        DataHolder().listaPosts.add(temp);
      }
    }, onError: (error) {
      print("Listen failed: $error");
    });
  }

}