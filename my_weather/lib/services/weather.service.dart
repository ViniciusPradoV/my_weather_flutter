import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:my_weather/services/ip.service.dart';

class WeatherService {
  Future<Map<String, dynamic>> fetchWeatherData() async {
    try {
      final result = await GetIt.instance<IpService>().getUserIpAddress();

      const abstractApiKey = '6fd0506e12fc479dbe3699e12de4040b';

      const ipGeoLocationApiKey = '2c5525575c1946ad9fad47e296e71bb4';

      final decodedResult = jsonDecode(result);

      final response = await http.get(Uri.parse(
          'https://ipgeolocation.abstractapi.com/v1/?api_key=$abstractApiKey&ip_address=${decodedResult['ip']}'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final latitude = data['latitude'] as double;
        final longitude = data['longitude'] as double;

        final weatherResponse = await http.get(Uri.parse(
            'https://api.open-meteo.com/v1/forecast?latitude=$latitude&longitude=$longitude&current=temperature_2m,wind_speed_10m,relative_humidity_2m'));

        if (weatherResponse.statusCode == 200) {
          return json.decode(weatherResponse.body);
        } else {
          throw Exception('Failed to load weather data');
        }
      } else {
        throw Exception('Failed to load approximate coordinates');
      }
    } catch (e) {
      throw Exception('Error fetching weather data: $e');
    }
  }
}
