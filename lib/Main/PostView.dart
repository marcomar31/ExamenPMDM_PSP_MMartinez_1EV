import 'package:flutter/material.dart';
import '../FirestoreObjects/FbPost.dart';
import '../Singletone/DataHolder.dart';

class PostView extends StatefulWidget {
  const PostView({super.key});

  @override
  State<PostView> createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  FbPost selectedPost = FbPost(titulo: "Cargando...", cuerpo: "Cargando...", sUrlImage: "");

  @override
  void initState() {
    super.initState();
    cargarPostGuardadoEnCache();
  }

  void cargarPostGuardadoEnCache() async {
    var temp1 = await DataHolder().loadCachedFbPost();
    setState(() {
      selectedPost = temp1!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            selectedPost.titulo,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: const Color.fromRGBO(22, 36, 71, 1),
        ),
        body: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Column(children: [
            Padding(padding: const EdgeInsets.only(top: 20), child:
            (selectedPost.sUrlImage == "")
                ? Container(width: 300, height: 300, color: const Color.fromRGBO(228, 63, 90, 1), child:
                    const Align( alignment: Alignment.center,
                      child: Text("Post sin imagen"),
                    ),
                  )
                : Image.network(selectedPost.sUrlImage, width: 300, height: 300,),
            ),
            const SizedBox(height: 30,),
            Text(
              selectedPost.cuerpo,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ],),
        ],),
      backgroundColor: const Color.fromRGBO(31, 64, 104, 1),
    );
  }
}