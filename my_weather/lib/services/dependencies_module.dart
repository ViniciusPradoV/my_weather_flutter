import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:my_weather/services/auth.service.dart';
import 'package:my_weather/services/geocoding.service.dart';
import 'package:my_weather/services/ip.service.dart';
import 'package:my_weather/services/weather.service.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<SharedPreferences> get sharedPreferences async {
  return await SharedPreferences.getInstance();
}

Future<void> setupDependencies() async {
  try {
    final prefs = await sharedPreferences;
    getIt.registerSingleton<SharedPreferences>(prefs);
    getIt.registerSingleton<AuthService>(AuthService());
    getIt.registerSingleton<IpService>(IpService(http.Client()));
    getIt.registerSingleton<GeocodingService>(GeocodingService());
    getIt.registerSingleton<WeatherService>(WeatherService(http.Client()));
  } catch (e) {
    print('Error initializing dependencies: $e');
  }
}
