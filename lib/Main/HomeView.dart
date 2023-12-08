import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:examenpmdm_pap_mmartinez_1ev/Singletone/DataHolder.dart';
import 'package:flutter/material.dart';

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
        backgroundColor: const Color.fromRGBO(22, 36, 71, 1),
        automaticallyImplyLeading: false,
      ),
      body:
      Padding(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16), child:
        /*
        Center(child: ListView.separated(
          padding: const EdgeInsets.all(8),
          itemCount: listaPosts.length,
          itemBuilder: creadorDeItemLista,
          separatorBuilder: creadorDeSeparadorLista),
        ),
         */
        Center(child: creadorDeItemMatriz(context, listaPosts.length),)
      ),
      backgroundColor: const Color.fromRGBO(31, 64, 104, 1),
    );
  }
}