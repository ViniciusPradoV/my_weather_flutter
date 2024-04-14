import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:my_weather/screens/weather_screen.dart';
import 'package:my_weather/services/auth.service.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatelessWidget {
  final AuthService authService = GetIt.instance<AuthService>();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.wb_sunny,
              size: 64,
              color: Colors.yellow,
            ),
            const SizedBox(height: 16),
            Text(
              'Welcome to My Weather Login!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Please enter your credentials to continue.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            Container(
              width: 200,
              child: TextFormField(
                controller: usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  prefixIcon: Icon(Icons.person),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              width: 200,
              child: TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () async {
                final success = await authService.login(
                    usernameController.text, passwordController.text);
                if (success) {
                  Fluttertoast.showToast(
                    msg: 'Login successful!',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                  );

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WeatherScreen()),
                  );
                } else {
                  Fluttertoast.showToast(
                    msg: 'Invalid username or password',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                  );
                }
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
