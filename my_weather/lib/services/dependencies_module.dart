import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:my_weather/services/ip.service.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  getIt.registerSingleton<IpService>(IpService(http.Client()));

}