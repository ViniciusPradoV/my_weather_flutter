import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:my_weather/services/auth.service.dart';

void main() {
  group('AuthService', () {
    AuthService? authService;
    final getIt = GetIt.instance;

    setUp(() {
      getIt.registerSingleton(AuthService());
      authService = getIt<AuthService>();
    });

    test('registerUser - valid input', () async {
      final result =
          await authService?.registerUser('testuser', 'secretpassword');
      expect(result, true);
    });

    test('registerUser - empty input', () async {
      final result = await authService?.registerUser('', '');
      expect(result, false);
    });

    test('verifyUser - valid credentials', () async {
      await authService?.registerUser('testuser', 'secretpassword');
      final result =
          await authService?.verifyUser('testuser', 'secretpassword');
      expect(result, true);
    });

    test('verifyUser - invalid username', () async {
      final result =
          await authService?.verifyUser('nonexistentuser', 'secretpassword');
      expect(result, false);
    });

    test('verifyUser - invalid password', () async {
      await authService?.registerUser('testuser', 'secretpassword');
      final result = await authService?.verifyUser('testuser', 'wrongpassword');
      expect(result, false);
    });
    tearDown(() {
      getIt.reset();
    });
  });
}
