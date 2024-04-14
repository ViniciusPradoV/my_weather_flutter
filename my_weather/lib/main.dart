import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:my_weather/screens/login_screen.dart';
import 'package:my_weather/screens/weather_screen.dart';
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
