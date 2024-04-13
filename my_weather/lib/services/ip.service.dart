import 'package:http/http.dart' as http;

class IpService {
  Future<String> getUserIpAddress() async {
    final response = await http.get(Uri.parse('https://api.ipify.org?format=json'));
    if (response.statusCode == 200) {
      final ipAddress = response.body;
      return ipAddress;
    } else {
      throw Exception('Failed to fetch IP address');
    }
  }
}