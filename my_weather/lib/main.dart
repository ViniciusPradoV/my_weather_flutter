import 'package:flutter/material.dart';
import 'package:my_weather/screens/register_screen.dart';
import 'package:my_weather/services/dependencies_module.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
