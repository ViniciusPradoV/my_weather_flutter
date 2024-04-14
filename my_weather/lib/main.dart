import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:my_weather/services/auth.service.dart';
import 'package:my_weather/services/dependencies_module.dart';
import 'package:my_weather/services/weather.service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  await setupDependencies();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final prefs = getIt<SharedPreferences>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Weather App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: LoginScreen(),
    );
  }
}

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  AuthWrapperState createState() => AuthWrapperState();
}

class AuthWrapperState extends State<AuthWrapper> {
  final AuthService authService = GetIt.instance<AuthService>();
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    setupSharedPreferences();
  }

  Future<void> setupSharedPreferences() async {
    final isLoggedIn = await authService.checkLoginStatus();
    setState(() {
      this.isLoggedIn = isLoggedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoggedIn ? WeatherScreen() : LoginScreen();
  }
}

class WeatherScreen extends StatelessWidget {
  WeatherScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Weather App'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: FutureBuilder<Map<String, dynamic>>(
          future: GetIt.instance<WeatherService>().fetchWeatherData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator(
                color: Colors.blue,
              );
            } else if (snapshot.hasError) {
              return const Text(
                'Error loading weather data',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.red,
                ),
              );
            } else {
              final currentTemperature =
                  snapshot.data?['current']['temperature_2m'];
              final windSpeed = snapshot.data?['current']['wind_speed_10m'];

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Current Weather',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const FaIcon(
                        FontAwesomeIcons.thermometer,
                        size: 24,
                        color: Colors.blue,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '$currentTemperature°C',
                        style: TextStyle(
                          fontSize: 36,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const FaIcon(
                        FontAwesomeIcons.wind,
                        size: 24,
                        color: Colors.grey,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Wind speed: $windSpeed km/h',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}

class LoginScreen extends StatelessWidget {
  final AuthService authService = GetIt.instance<AuthService>();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _usernameController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();

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
                controller: _usernameController,
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
                controller: _passwordController,
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
                    _usernameController.text, _passwordController.text);
                if (success) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WeatherScreen()),
                  );
                } else {
                  print('Invalid username or password');
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
