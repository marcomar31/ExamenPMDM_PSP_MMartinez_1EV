import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:examenpmdm_pap_mmartinez_1ev/Singletone/DataHolder.dart';
import 'package:flutter/material.dart';

import '../CustomViews/ButtomBarCustomizado.dart';
import '../CustomViews/DrawerCustomizado.dart';
import '../CustomViews/PostsGridView.dart';
import '../CustomViews/PostsListView.dart';
import '../FirestoreObjects/FbPost.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  final List<FbPost> listaPosts = [];
  bool blIsList = true;

  Widget? creadorDeItemLista(BuildContext context, int index) {
    return PostsListView(post: listaPosts[index],
      dFontSize: 20, iPosicion: index, onItemListClickedFun: (int index) { print("Click");});
  }

  Widget creadorDeSeparadorLista(BuildContext context, int index) {
    return const Column(
      children: [
        Divider(color: Color.fromRGBO(22, 36, 71, 1), thickness: 2,),
      ],
    );
  }

  Widget? creadorDeItemMatriz(BuildContext context, int index){
    return PostsGridView(post: listaPosts, iPosicion: index, onItemListaClickedFunction: (int index) { print("Click");}, numPostsFila: 4,);
  }

  Widget? celdasOLista(bool isList) {
    if (isList) {
      return ListView.separated(
          padding: const EdgeInsets.all(8),
          itemCount: listaPosts.length,
          itemBuilder: creadorDeItemLista,
          separatorBuilder: creadorDeSeparadorLista
      );
    } else {
      return creadorDeItemMatriz(context, listaPosts.length);
    }
  }

  void onClickBottonMenu(int indice) {
    setState(() {
      if(indice == 0){
        blIsList = true;
      }
      else if(indice == 1){
        blIsList = false;
      }
    });
  }

  void onPressedDrawer(int indice){
    if (indice == 0) {
      Navigator.of(context).popAndPushNamed("/home_view");
    } else if(indice == 1){
      Navigator.of(context).popAndPushNamed("/ajustes_view");
    } else if(indice == 2){
      DataHolder().fbAdmin.logOutUsuario();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Se ha cerrado la sesión correctamente")));
      Navigator.of(context).popAndPushNamed("/login_view");
    }
  }

  void onPressedItemList(int index) {
    DataHolder().selectedPost = listaPosts[index];
    DataHolder().saveSelectedPostInCache();
    Navigator.of(context).pushNamed("/postview");
  }

  @override
  void initState() {
    super.initState();
    DataHolder().fbAdmin.descargarPosts(db).then((listaPosts) {
      setState(() {
        this.listaPosts.addAll(listaPosts);
      });
    });  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
        "HOME",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color.fromRGBO(22, 36, 71, 1),
      ),
      body:
      Padding(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16), child:
        Center(child: celdasOLista(blIsList)),
      ),
      drawer: DrawerCustomizado(onItemTap: onPressedDrawer),
      bottomNavigationBar: ButtomBarCustomizado(onBotonesClicked: onClickBottonMenu),
      backgroundColor: const Color.fromRGBO(31, 64, 104, 1),
    );
  }
}