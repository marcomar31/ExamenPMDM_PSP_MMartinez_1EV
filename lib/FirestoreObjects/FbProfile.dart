import 'package:cloud_firestore/cloud_firestore.dart';

class FbProfile {
  final String nombre;
  String sUrlProfilePicture;

  FbProfile({
    required this.nombre,
    required this.sUrlProfilePicture,
  });

  factory FbProfile.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return FbProfile(
      nombre: data?['nombre'] ?? '',
      sUrlProfilePicture:  data?['foto_perfil'] ?? ''
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "nombre": nombre ?? '',
      "foto_perfil": sUrlProfilePicture ?? '',
    };
  }
}