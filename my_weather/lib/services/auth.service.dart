import 'dart:convert';
import 'package:crypto/crypto.dart';

class AuthService {
  final Map<String, String> _users = {};

  Future<bool> registerUser(String username, String password) async {
    if (username.isNotEmpty && password.isNotEmpty) {
      final hashedPassword = sha256.convert(utf8.encode(password)).toString();
      _users[username] = hashedPassword;
      return true;
    } else {
      return false;
    }
  }

  Future<bool> verifyUser(String username, String password) async {
    if (_users.containsKey(username)) {
      final hashedPassword = sha256.convert(utf8.encode(password)).toString();
      return _users[username] == hashedPassword;
    } else {
      return false;
    }
  }
}
