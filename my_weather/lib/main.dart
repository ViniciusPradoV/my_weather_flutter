import 'package:flutter/material.dart';
import 'package:my_weather/screens/register_screen.dart';
import 'package:my_weather/services/dependencies_module.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  await setupDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Weather App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: RegisterScreen(),
    );
  }
}
