import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:examenpmdm_pap_mmartinez_1ev/CustomViews/ButtonTextCustomizado.dart';
import 'package:examenpmdm_pap_mmartinez_1ev/CustomViews/EditTextCustomizado.dart';
import 'package:flutter/material.dart';

import '../FirestoreObjects/FbPost.dart';
import '../Singletone/DataHolder.dart';

class EditPostView extends StatefulWidget{
  const EditPostView({super.key});

  @override
  State<EditPostView> createState() => _EditPostViewState();
}

class _EditPostViewState extends State<EditPostView> {
  FirebaseFirestore firebaseFirestore = DataHolder().db;

  TextEditingController tecTitulo = TextEditingController();
  TextEditingController tecCuerpo = TextEditingController();

  FbPost selectedPost = FbPost(titulo: "Cargando...", cuerpo: "Cargando...", sUrlImage: "");

  void cargarPostGuardadoEnCache() async {
    var temp1 = await DataHolder().loadCachedFbPost();
    setState(() {
      selectedPost = temp1!;
    });
    tecTitulo.text = selectedPost.titulo;
    tecCuerpo.text = selectedPost.cuerpo;
  }

  void onPressedAceptar() async {
    if (tecTitulo.text.isNotEmpty && tecCuerpo.text.isNotEmpty) {
      FbPost post = await DataHolder().fbAdmin.updatePost(firebaseFirestore, selectedPost.uid!, tecTitulo.text, tecCuerpo.text);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Se ha editado el post exitosamente")));
      Navigator.of(context).pop(post);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Todos los campos deben estar rellenos")));
    }
  }

  void onPressedCancelar() {
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    super.initState();
    cargarPostGuardadoEnCache();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "EDITAR POST",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromRGBO(22, 36, 71, 1),
      ),
      body: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Row(
            children: [
              Column(
                children: [
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
                  Padding(padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 16),
                      child: EditTextCustomizado(tec: tecTitulo, labelText: "Título")
                  ),
                  Padding(padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 16),
                    child: EditTextCustomizado(tec: tecCuerpo, labelText: "Cuerpo")
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                        child: ButtonTextCustomizado(buttonText: "ACEPTAR", onPressed: onPressedAceptar),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                        child: ButtonTextCustomizado(buttonText: "CANCELAR", onPressed: onPressedCancelar),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ],
      ),
      backgroundColor: const Color.fromRGBO(31, 64, 104, 1),
    );
  }
}