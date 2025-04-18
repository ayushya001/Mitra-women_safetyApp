import 'package:flutter/material.dart';

class ContactButtonProvider extends ChangeNotifier {
  bool _isPressed = false;

  bool get isPressed => _isPressed;

  void setPressed(bool value) {
    _isPressed = value;
    notifyListeners();
  }
}