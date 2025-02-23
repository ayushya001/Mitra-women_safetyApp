import 'package:flutter/material.dart';

class circularprgsbar extends ChangeNotifier {

  // final currentUser = FirebaseAuth.instance.currentUser;


  bool _loading = false;

  bool get loading => _loading;

  setloading(bool value) {
    _loading = value;
    notifyListeners();
  }
}