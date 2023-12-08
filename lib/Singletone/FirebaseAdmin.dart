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

  Future<List<FbPost>> descargarPosts(FirebaseFirestore db) async {
    CollectionReference<FbPost> ref = db.collection("Posts")
        .withConverter(fromFirestore: FbPost.fromFirestore, toFirestore: (FbPost post, _) => post.toFirestore());

    QuerySnapshot<FbPost> querySnapshot = await ref.get();
    List<FbPost> listaPosts = querySnapshot.docs.map((doc) => doc.data()).toList();
    return listaPosts;
  }
}