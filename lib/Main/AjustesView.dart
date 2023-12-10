import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:examenpmdm_pap_mmartinez_1ev/CustomViews/ButtonTextCustomizado.dart';
import 'package:examenpmdm_pap_mmartinez_1ev/CustomViews/EditTextCustomizado.dart';
import 'package:examenpmdm_pap_mmartinez_1ev/FirestoreObjects/FbProfile.dart';
import 'package:examenpmdm_pap_mmartinez_1ev/Singletone/DataHolder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../CustomViews/DrawerCustomizado.dart';

class AjustesView extends StatefulWidget {
  const AjustesView({Key? key}) : super(key: key);

  @override
  _AjustesViewState createState() => _AjustesViewState();
}

class _AjustesViewState extends State<AjustesView> {
  FirebaseFirestore db = DataHolder().db;
  late User usuarioActual;
  late String rutaFotoEnNube = "";

  late FbProfile perfilActual;
  late FbProfile nuevoPerfil;
  TextEditingController tecNombre = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  File? _imagePreview;

  void onPressedCamera() async {
    XFile? image = await _picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      setState(() {
        _imagePreview = File(image.path);
      });
    }
  }

  void onPressedGallery() async {
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _imagePreview = File(image.path);
      });
    }
  }

  void onPressedDrawer(int indice) {
    if (indice == 0) {
      Navigator.of(context).popAndPushNamed("/home_view");
    } else if (indice == 1) {
      Navigator.of(context).popAndPushNamed("/ajustes_view");
    } else if (indice == 2) {
      DataHolder().fbAdmin.logOutUsuario();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Se ha cerrado la sesión correctamente")),
      );
      Navigator.of(context).popAndPushNamed("/login_view");
    }
  }

  void onPressedGuardar() {
    if (tecNombre.text.isNotEmpty) {
      if (_imagePreview != null) {
        String nuevaRutaFotoEnNube = "profile_pictures/${FirebaseAuth.instance.currentUser!.uid}/profile_picture_${DateTime.now().year}_${DateTime.now().month}_${DateTime.now().day}";
        String rutaAFicheroEnNube = DataHolder().fbAdmin.subirImagen(nuevaRutaFotoEnNube, _imagePreview!) as String;
        nuevoPerfil = FbProfile(nombre: tecNombre.text, sUrlProfilePicture: rutaAFicheroEnNube);
      } else {
        nuevoPerfil = FbProfile(nombre: tecNombre.text, sUrlProfilePicture: rutaFotoEnNube);
      }
      DataHolder().fbAdmin.updatePerfilUsuario(db, nuevoPerfil);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("El nombre no puede estar en blanco")));
    }
  }

  @override
  void initState() {
    super.initState();
    usuarioActual = FirebaseAuth.instance.currentUser!;
    DataHolder().fbAdmin.loadUserProfile(db).then((loadedProfile) {
      if (loadedProfile != null) {
        setState(() {
          perfilActual = loadedProfile;
          tecNombre.text = perfilActual.nombre;
          rutaFotoEnNube = perfilActual.sUrlProfilePicture;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "AJUSTES",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color.fromRGBO(22, 36, 71, 1),
      ),
      drawer: DrawerCustomizado(onItemTap: onPressedDrawer),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16), // Espacio en la parte superior
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Perfil de Usuario',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 70,
                  backgroundColor: Colors.white,
                  child: ClipOval(
                    child: SizedBox(
                      width: 140,
                      height: 140,
                      child: (rutaFotoEnNube != "")
                          ? Image.network("https://firebasestorage.googleapis.com/v0/b/examen-pmdm-psp-mmartinez-1ev.appspot.com/o/profile_pictures%2FJvDPotOGR8bg2dG2AjOHTsvVyg52%2Fprofile_picture_2023_12_10?alt=media&token=fcbb866a-122c-4492-8225-fcad4aed0462", fit: BoxFit.cover)
                          : const Icon(Icons.person, size: 95, color: Colors.grey),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (!kIsWeb)
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: ButtonTextCustomizado(
                      buttonText: "Tomar foto",
                      onPressed: onPressedCamera,
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: ButtonTextCustomizado(
                    buttonText: "Seleccionar de la galería",
                    onPressed: onPressedGallery,
                  ),
                ),
              ],
            ),
            Padding(padding: const EdgeInsets.all(16.0),
              child: EditTextCustomizado(tec: tecNombre, labelText: "Nombre",)
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Correo electrónico: ${usuarioActual?.email}',
                style: const TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 40,),
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ButtonTextCustomizado(
                  buttonText: "GUARDAR CAMBIOS",
                  onPressed: onPressedGuardar,
                ),
              ],
            ),
          ],),
      ),
      backgroundColor: const Color.fromRGBO(31, 64, 104, 1),
    );
  }
}
