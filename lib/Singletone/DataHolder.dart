import 'package:flutter/material.dart';
import 'FirebaseAdmin.dart';

class DataHolder {

  static final DataHolder _dataHolder = DataHolder._internal();
  FirebaseAdmin fbAdmin = FirebaseAdmin();

  DataHolder._internal();

  factory DataHolder() {
    return _dataHolder;
  }

  void initDataHolder() {

  }
}