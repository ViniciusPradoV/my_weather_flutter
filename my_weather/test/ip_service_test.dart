import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:my_weather/services/ip.service.dart';

@GenerateNiceMocks([MockSpec<http.Client>()])
import 'ip_service_test.mocks.dart';

void main() {
  group('IpService', () {
    test('getUserIpAddress - success', () async {
      final mockClient = MockClient();
      final ipService = IpService(mockClient);

      when(mockClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async {
        return http.Response('{"ip": "127.0.0.1"}', 200);
      });

      final result = await ipService.getUserIpAddress();
      
      expect(result, '127.0.0.1');
    });

    test('getUserIpAddress - failure', () async {
      final mockClient = MockClient();
      final ipService = IpService(mockClient);

      when(mockClient.get(any, headers: captureAnyNamed('headers')))
          .thenAnswer((_) async {
        return http.Response('Error fetching IP address', 404);
      });

      expect(() async => await ipService.getUserIpAddress(),
          throwsA(isA<Exception>()));
    });
  });
}
