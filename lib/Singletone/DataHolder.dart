import 'package:cloud_firestore/cloud_firestore.dart';
import '../FirestoreObjects/FbPost.dart';
import 'FirebaseAdmin.dart';

class DataHolder {

  static final DataHolder _dataHolder = DataHolder._internal();
  FirebaseAdmin fbAdmin = FirebaseAdmin();
  FirebaseFirestore db = FirebaseFirestore.instance;

  DataHolder._internal();

  factory DataHolder() {
    return _dataHolder;
  }

  void initDataHolder() {

  }
}