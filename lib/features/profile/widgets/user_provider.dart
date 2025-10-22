import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  String _name = "Jegathish"; // initial name
  String _email = "jegathish.vk18@gmail.com";
  String _no = "9043296001";
  String get name => _name;
  String get email => _email;
  String get no => _no;
  void updateName(String newName, String email, String no) {
    _name = newName;
    _email = email;
    _no = no;
    notifyListeners();
  }
}
