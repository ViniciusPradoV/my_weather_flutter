import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:my_weather/screens/login_screen.dart';
import 'package:my_weather/services/auth.service.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterScreen extends StatelessWidget {
  final AuthService authService = GetIt.instance<AuthService>();

  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController confirmPasswordController =
        TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.wb_sunny,
              size: 64,
              color: Colors.yellow,
            ),
            const SizedBox(height: 16),
            const Text(
              'Welcome to My Weather Registration!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Please create your account.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: 200,
              child: TextFormField(
                controller: usernameController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  prefixIcon: Icon(Icons.person),
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: 200,
              child: TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: 200,
              child: TextFormField(
                controller: confirmPasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Confirm Password',
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                final username = usernameController.text;
                final password = passwordController.text;
                final confirmPassword = confirmPasswordController.text;

                if (password != confirmPassword) {
                  Fluttertoast.showToast(
                    msg: 'Passwords do not match',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    webBgColor: 'RGB(255, 0, 0)',
                    backgroundColor: const Color.fromARGB(255, 243, 65, 52),
                  );
                  return;
                }

                authService.registerUser(username, password);
                Fluttertoast.showToast(
                  msg: 'User registered with success!',
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  webBgColor: 'RGB(0, 255, 0)',
                  backgroundColor: Colors.green,
                );
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                      builder: (context) => LoginScreen(
                          authService: GetIt.instance<AuthService>())),
                );
              },
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
