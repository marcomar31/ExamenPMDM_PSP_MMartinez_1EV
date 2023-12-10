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

  Future<void> updatePerfilUsuario(FirebaseFirestore db, FbProfile perfil) async{
    String uidUsuario = FirebaseAuth.instance.currentUser?.uid ?? '';
    if (uidUsuario.isNotEmpty) {
      await db.collection("Usuarios").doc(uidUsuario).set(perfil.toFirestore());
    } else {
      print('Error: El UID del usuario actual está vacío.');
    }
  }

  Future<FbProfile?> loadUserProfile(FirebaseFirestore db) async {
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        DocumentSnapshot<Map<String, dynamic>> userDoc =
        await db.collection("Usuarios").doc(currentUser.uid).get();

        if (userDoc.exists) {
          return FbProfile.fromFirestore(userDoc, null);
        } else {
          // El usuario no existe en Firestore
          print("El usuario no existe");
          return null;
        }
      }
    } catch (e) {
      print("Error al cargar el perfil del usuario: $e");
    }
  }

  Future<File?> cargarImagenDesdeNube(String url) async {
    try {
      Reference storageReference = FirebaseStorage.instance.ref().child(url);
      final File imageFile = File(await storageReference.getDownloadURL());
      return imageFile;
    } catch (e) {
      print("Error al cargar la imagen desde la nube: $e");
      return null;
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

  Future<String?> subirImagen(String rutaEnNube, File imagen) async {
    final storageRef = FirebaseStorage.instance.ref();

    final rutaAFicheroEnNube = storageRef.child(rutaEnNube);

    final metadata = SettableMetadata(contentType: "image/jpeg");
    try {
      await rutaAFicheroEnNube.putFile(imagen, metadata);
      return rutaAFicheroEnNube.getDownloadURL();
    } on FirebaseException {
      print("Se ha producido un error al subir la imagen");
      return null;
    }
  }
}