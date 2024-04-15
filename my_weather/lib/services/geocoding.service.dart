import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class GeocodingService {
  Future<Response?> getLocationDataFromIp(String ipAddress,
      {http.Client? client}) async {
    try {
      const abstractApiKey = '6fd0506e12fc479dbe3699e12de4040b';
      final response = await (client ?? http.Client()).get(Uri.parse(
          'https://ipgeolocation.abstractapi.com/v1/?api_key=$abstractApiKey&ip_address=$ipAddress'));

      if (response.statusCode == 200) {
        return response;
      } else {
        throw Exception('Failed to load location data');
      }
    } catch (e) {
      print('Error fetching approximate coordinates: $e');
      return null;
    }
  }
}
