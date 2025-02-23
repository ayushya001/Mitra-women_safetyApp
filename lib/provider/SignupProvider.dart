import 'package:flutter/material.dart';

class Signupprovider extends ChangeNotifier {

  bool _loading = false;

  bool get loading => _loading;

  setloading(bool value) {
    _loading = value;
    notifyListeners();
  }

}