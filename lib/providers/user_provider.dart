import 'package:RaithaSethu/models/usermodel.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
      id: '',
      name: '',
      email: '',
      password: '',
      address: '',
      token: '',
      cart: []);

  User get user => _user;

  void setUser(String user) {
    _user = User.fromJson(user);
    print(_user);
    notifyListeners();
  }

  void setUserModel(User user) {
    _user = user;
    notifyListeners();
  }

  void setUserFromModel(User user) {}
}
