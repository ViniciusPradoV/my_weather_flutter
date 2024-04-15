import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherService {
  final http.Client _httpClient;

  WeatherService(this._httpClient);

  Future<Map<String, dynamic>> fetchWeatherData(dynamic data) async {
    final latitude = data['latitude'] as double;
    final longitude = data['longitude'] as double;

    final weatherResponse = await _httpClient.get(Uri.parse(
        'https://api.open-meteo.com/v1/forecast?latitude=$latitude&longitude=$longitude&current=temperature_2m,wind_speed_10m,relative_humidity_2m,precipitation,rain&forecast_days=1'));

    if (weatherResponse.statusCode == 200) {
      return json.decode(weatherResponse.body);
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
