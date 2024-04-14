import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  Future<bool> login(String username, String password) async {
    if (username == 'Olly Olly' && password == '123456') {
      final prefs = GetIt.instance<SharedPreferences>();
      await prefs.setString('auth_token', 'your_token_here');
      return true;
    } else {
      return false;
    }
  }

  Future<bool> checkLoginStatus() async {
    final token = GetIt.instance<SharedPreferences>().getString('auth_token');
    return token != null;
  }
}