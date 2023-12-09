import 'package:cloud_firestore/cloud_firestore.dart';

class FbPost {
  String? uid;
  final String titulo;
  final String cuerpo;
  final String sUrlImage;

  FbPost({
    this.uid,
    required this.titulo,
    required this.cuerpo,
    required this.sUrlImage,
  });

  factory FbPost.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    FbPost post = FbPost(
      uid: snapshot.id,
      titulo: data?['titulo'],
      cuerpo: data?['cuerpo'],
      sUrlImage: data?['sUrlImage'] ?? "",
    );
    return post;
  }

  Map<String, dynamic> toFirestore() {
    return {
      "titulo": titulo,
      "cuerpo": cuerpo,
      "sUrlImage": sUrlImage,
    };
  }

  @override
  String toString() {
    return 'FbPost{uid: $uid, titulo: $titulo, cuerpo: $cuerpo, sUrlImage: $sUrlImage}';
  }
}