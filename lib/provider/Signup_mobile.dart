import 'package:flutter/cupertino.dart';

class SignupMobile extends ChangeNotifier{


  bool _loading = false;
  bool _loading2 = false;

  bool get loading => _loading;
  bool get loading2 => _loading2;

  setloading(bool value) {
    _loading = value;
    notifyListeners();
  }
  setloading2(bool value) {
    _loading2 = value;
    notifyListeners();
  }

}