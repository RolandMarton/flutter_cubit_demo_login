import 'package:flutter/material.dart';

class LoginFormController {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  String? validateUsername(String? value) {
    if (value == null || value.isEmpty) return 'Username required';
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.length < 4) return 'Password too short';
    return null;
  }

  String? get fakeEmail => '${usernameController.text}@example.com';

  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
  }
}