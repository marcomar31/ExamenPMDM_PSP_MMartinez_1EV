import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:examenpmdm_pap_mmartinez_1ev/Singletone/DataHolder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
    List<FbPost> listaPosts = [];

    CollectionReference<FbPost> ref = db.collection("Posts")
        .withConverter(
      fromFirestore: FbPost.fromFirestore,
      toFirestore: (FbPost post, _) => post.toFirestore(),
    );

    QuerySnapshot<FbPost> querySnapshot = await ref.get();

    for (var doc in querySnapshot.docs) {
      FbPost post = doc.data();
      listaPosts.add(post);
    }

    return listaPosts;
  }


  void subirNuevoPost(FirebaseFirestore db, FbPost post) {
    CollectionReference<FbPost> postsRef = db.collection("Posts")
        .withConverter(
      fromFirestore: FbPost.fromFirestore,
      toFirestore: (FbPost post, _) => post.toFirestore(),
    );
    postsRef.add(post);
  }

  Future<FbPost> updatePost(FirebaseFirestore db, String uid, String nuevoTitulo, String nuevoCuerpo) async {
    await db.collection("Posts").doc(uid).update({
      "titulo": nuevoTitulo,
      "cuerpo": nuevoCuerpo,
    });

    DocumentSnapshot<Map<String, dynamic>> snapshot = await db.collection("Posts").doc(uid).get();
    FbPost postActualizado = FbPost.fromFirestore(snapshot, null);

    return postActualizado;
  }

  void subirImagen(String rutaEnNube, File imagen) async {
    final storageRef = FirebaseStorage.instance.ref();

    // String rutaEnNube = "profile_pictures/${FirebaseAuth.instance.currentUser!.uid}/profile_picture_${DateTime.now().year}_${DateTime.now().month}_${DateTime.now().day}";
    final rutaAFicheroEnNube = storageRef.child(rutaEnNube);

    final metadata = SettableMetadata(contentType: "image/jpeg");
    try {
      await rutaAFicheroEnNube.putFile(imagen, metadata);

    } on FirebaseException {
      print("Se ha producido un error al subir la imagen");
    }
  }
}