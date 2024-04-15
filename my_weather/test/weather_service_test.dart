import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:my_weather/services/weather.service.dart';
import 'package:http/http.dart' as http;

@GenerateNiceMocks([MockSpec<http.Client>()])
import 'weather_service_test.mocks.dart';

void main() {
  group('WeatherService', () {
    test('fetchWeatherData returns weather data', () async {
      final mockClient = MockClient();
      final weatherService = WeatherService(mockClient);

      when(mockClient.get(any)).thenAnswer((_) async => http.Response(
          json.encode({'temperature': 25.0, 'windSpeed': 10.0}), 200));

      final data = {'latitude': 47.6, 'longitude': -122.3};
      final result = await weatherService.fetchWeatherData(data);

      expect(result, isA<Map<String, dynamic>>());
      expect(result['temperature'], equals(25.0));
      expect(result['windSpeed'], equals(10.0));
    });

    test('fetchWeatherData throws exception on error', () async {
      final mockClient = MockClient();
      final weatherService = WeatherService(mockClient);

      when(mockClient.get(any)).thenAnswer((_) async => http.Response('', 404));

      final data = {'latitude': 47.6, 'longitude': -122.3};

      expect(() => weatherService.fetchWeatherData(data),
          throwsA(const TypeMatcher<Exception>()));
    });
  });
}
