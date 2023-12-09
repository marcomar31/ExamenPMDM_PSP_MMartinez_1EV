import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../FirestoreObjects/FbPost.dart';
import 'FirebaseAdmin.dart';

class DataHolder {

  static final DataHolder _dataHolder = DataHolder._internal();
  FirebaseFirestore db = FirebaseFirestore.instance;
  FirebaseAdmin fbAdmin = FirebaseAdmin();
  FbPost? selectedPost;

  DataHolder._internal();

  factory DataHolder() {
    return _dataHolder;
  }

  void initDataHolder() {

  }

  void saveSelectedPostInCache() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('fbpost_uid', selectedPost?.uid ?? "");
    prefs.setString('fbpost_titulo', selectedPost?.titulo ?? "");
    prefs.setString('fbpost_cuerpo', selectedPost?.cuerpo ?? "");
    prefs.setString('fbpost_urlImage', selectedPost?.sUrlImage ?? "");
  }

  Future<FbPost?> loadCachedFbPost() async {
    if(selectedPost!=null) return selectedPost;

    SharedPreferences prefs = await SharedPreferences.getInstance();

    print("UID antes de guardar en SharedPreferences: ${selectedPost?.uid}");
    String? fbpostUid = prefs.getString('fbpost_uid');
    fbpostUid ??= "";

    String? fbpostTitulo = prefs.getString('fbpost_titulo');
    fbpostTitulo??="";

    String? fbpostCuerpo = prefs.getString('fbpost_cuerpo');
    fbpostCuerpo??="";

    String? fbpostUrlImage = prefs.getString('fbpost_urlImage');
    fbpostUrlImage??="";

    print("SHARED PREFERENCES --> fbpostTitulo: $fbpostTitulo, fbpostUid: $fbpostUid");
    selectedPost = FbPost(titulo: fbpostTitulo, cuerpo: fbpostCuerpo, sUrlImage: fbpostUrlImage, uid: fbpostUid);

    return selectedPost;
  }
}