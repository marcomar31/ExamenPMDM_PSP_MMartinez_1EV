import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Singletone/DataHolder.dart';
import 'firebase_options.dart';

import 'MyApp.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  DataHolder().initDataHolder();
  runApp(const MyApp());
}
