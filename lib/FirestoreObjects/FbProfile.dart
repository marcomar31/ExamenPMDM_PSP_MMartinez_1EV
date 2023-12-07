import 'package:cloud_firestore/cloud_firestore.dart';

class FbProfile {
  final String nombre;

  FbProfile({
    required this.nombre,
  });

  factory FbProfile.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return FbProfile(
      nombre: data?['nombre'] ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "nombre": nombre ?? '',
    };
  }
}