import 'package:flutter/material.dart';

import '../FirestoreObjects/FbPost.dart';

class PostsListView extends StatelessWidget {

  final FbPost post;
  final double dFontSize;
  final int iPosicion;
  final Function(int indice)? onItemListClickedFun;

  const PostsListView({super.key,
    required this.post,
    required this.dFontSize,
    required this.iPosicion,
    this.onItemListClickedFun});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: SizedBox(
        height: 70,
        child: Row(
          children: [
            (post.sUrlImage != null && post.sUrlImage!.isNotEmpty)
                ? Image.network(
                    post.sUrlImage!,
                    width: 70,
                    height: 70,
                    fit: BoxFit.cover,
                  )
                : Image.asset("resources/MyLogo.png", width: 70, height: 70),
            const SizedBox(width: 15,),
            Text(
              post.titulo,
              style: TextStyle(
                color: Colors.white,
                fontSize: dFontSize,
              ),
            ),
            const Spacer(),
            TextButton(
              onPressed: null,
              child: Text("+", style: TextStyle(fontSize: dFontSize)),
            ),
          ],
        ),
      ),
      onTap: () {
        onItemListClickedFun!(iPosicion);
      },
    );

  }

}