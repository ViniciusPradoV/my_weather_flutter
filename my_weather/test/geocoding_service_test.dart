import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:my_weather/services/geocoding.service.dart';

void main() {
  group('GeocodingService', () {
    test('getLocationDataFromIp - success', () async {
      final geocodingService = GeocodingService();
      final mockResponse =
          http.Response('{"latitude": 37.7749, "longitude": -122.4194}', 200);

      final mockClient = MockClient((request) async => mockResponse);

      final result = await geocodingService.getLocationDataFromIp(
        '127.0.0.1',
        client: mockClient,
      );

      expect(result?.statusCode, 200);
      expect(result?.body, '{"latitude": 37.7749, "longitude": -122.4194}');
    });

    test('getLocationDataFromIp - failure', () async {
      final geocodingService = GeocodingService();
      final mockResponse = http.Response('Error fetching location data', 404);
      final mockClient = MockClient((request) async => mockResponse);

      final result = await geocodingService.getLocationDataFromIp(
        '127.0.0.1',
        client: mockClient,
      );

      expect(result, null);
    });
  });
}
