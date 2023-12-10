import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:examenpmdm_pap_mmartinez_1ev/FirestoreObjects/FbProfile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Singletone/DataHolder.dart';

class DrawerCustomizado extends StatefulWidget {
  final Function(int indice)? onItemTap;

  DrawerCustomizado({super.key, required this.onItemTap});

  @override
  State<DrawerCustomizado> createState() => _DrawerCustomizadoState();
}

class _DrawerCustomizadoState extends State<DrawerCustomizado> {
  FirebaseFirestore db = DataHolder().db;
  late User usuarioActual;
  String ruta = "";
  File? imagen;
  String nombre = "Cargando...";
  String email = "Cargando...";
  FbProfile perfilUsuario = FbProfile(nombre: "Cargando...", sUrlProfilePicture: "");

  @override
  void initState() {
    super.initState();
    usuarioActual = FirebaseAuth.instance.currentUser!;
    cargarPerfilUsuario();
  }

  Future<void> cargarPerfilUsuario() async {
    perfilUsuario = await DataHolder().fbAdmin.loadUserProfile(db) as FbProfile;
    ruta = perfilUsuario.sUrlProfilePicture!;
    if (ruta != "") {
      imagen = (perfilUsuario.sUrlProfilePicture != null)
          ? await DataHolder().fbAdmin.cargarImagenDesdeNube(ruta)
          : null;
    }
    setState(() {
      nombre = perfilUsuario.nombre;
      email = usuarioActual.email!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromRGBO(31, 64, 104, 1),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Colors.black,
            ),
            child:
            Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: ClipOval(
                    child: SizedBox(
                      width: 80,
                      height: 80,
                      child: (imagen != null)
                          ? Image.file(imagen!)
                          : const Icon(Icons.person, size: 40, color: Colors.grey),
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      nombre,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      email,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          ListTile(
            selectedColor: Colors.white,
            selected: true,
            title: const Row(
              children: [
                Icon(
                  Icons.home,
                  color: Colors.white,
                ),
                SizedBox(width: 16),
                Text('HOME'),
              ],
            ),
            onTap: () {
              widget.onItemTap!(0);
            },
          ),
          ListTile(
            selectedColor: Colors.white,
            selected: true,
            title: const Row(
              children: [
                Icon(
                  Icons.settings,
                  color: Colors.white,
                ),
                SizedBox(width: 16),
                Text('AJUSTES'),
              ],
            ),
            onTap: () {
              widget.onItemTap!(1);
            },
          ),
          ListTile(
            selectedColor: Colors.white,
            selected: true,
            title: const Row(
              children: [
                Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
                SizedBox(width: 16),
                Text('LOGOUT'),
              ],
            ),
            onTap: () {
              widget.onItemTap!(2);
            },
          ),
        ],
      ),
    );
  }
}
