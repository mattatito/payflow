import 'package:flutter/material.dart';
import 'package:payflow/modules/home/home_page.dart';
import 'package:payflow/shared/constants/routes.dart';

class AuthController {
  var _isAuthenticated = false;
  var _user;

  get user => _user;

  void setUser(BuildContext context, var user) {
    if (user != null) {
      _user = user;
      _isAuthenticated = true;
      Navigator.pushReplacementNamed(context, Routes.home);
    } else {
      _isAuthenticated = false;
      Navigator.pushReplacementNamed(context, Routes.login);
    }
  }
}
