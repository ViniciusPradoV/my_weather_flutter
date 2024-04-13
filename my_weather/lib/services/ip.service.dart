import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';

class IpService {
  final http.Client _httpClient;

  IpService(this._httpClient);

  Future<String> getUserIpAddress() async {
    try {
      final response =
          await _httpClient.get(Uri.parse('https://api.ipify.org?format=json'));
      if (response.statusCode == 200) {
        final ipAddress = response.body;
        return ipAddress;
      } else {
        throw Exception('Failed to fetch IP address');
      }
    } catch (e) {
      throw Exception('Error fetching IP address: $e');
    }
  }
}
