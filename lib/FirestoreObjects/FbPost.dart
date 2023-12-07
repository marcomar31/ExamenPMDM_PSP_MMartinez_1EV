import 'package:cloud_firestore/cloud_firestore.dart';

class FbPost {
  final String titulo;
  final String cuerpo;
  final String? sUrlImage;

  FbPost({
    required this.titulo,
    required this.cuerpo,
    this.sUrlImage,
  });

  factory FbPost.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return FbPost(
      titulo: data?['titulo'],
      cuerpo: data?['cuerpo'],
      sUrlImage: data?['sUrlImage'] ?? "",
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "titulo": titulo,
      "cuerpo": cuerpo,
      "sUrlImage": sUrlImage,
    };
  }
}