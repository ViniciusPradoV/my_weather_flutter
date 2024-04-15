import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:my_weather/services/geocoding.service.dart';
import 'package:my_weather/services/ip.service.dart';
import 'package:my_weather/services/weather.service.dart'; // Import your WeatherService

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  late String ipAddress;
  late dynamic location = {};

  @override
  void initState() {
    super.initState();
  }

  Future<void> _fetchIpAddressAndLocation() async {
    final ipService = GetIt.instance.get<IpService>();
    final geocodingService = GetIt.instance.get<GeocodingService>();
    ipAddress = await ipService.getUserIpAddress();
    location = await geocodingService.getLocationDataFromIp(ipAddress);
    location = jsonDecode(location.body);
  }

  Future<Map<String, dynamic>> _fetchWeatherData() async {
    final weatherService = GetIt.instance<WeatherService>();
    try {
      final weatherData = await weatherService.fetchWeatherData(location);
      return weatherData;
    } catch (e) {
      print('Error fetching weather data: $e');
      return {};
    }
  }

  Color getTemperatureColor(double temp) {
    if (temp < 20) {
      return Colors.blue;
    } else if (temp < 25) {
      return const Color.fromARGB(255, 92, 102, 92);
    } else {
      return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Weather App'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: FutureBuilder<Map<String, dynamic>>(
          future: _fetchIpAddressAndLocation().then((locationData) {
            return _fetchWeatherData();
          }),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator(
                color: Colors.blue,
              );
            } else if (snapshot.hasError) {
              return const Text(
                'Error loading weather data',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.red,
                ),
              );
            } else {
              final currentTemperature =
                  snapshot.data?['current']['temperature_2m'] ?? 'N/A';
              final windSpeed =
                  snapshot.data?['current']['wind_speed_10m'] ?? 'N/A';
              final relativeHumidity =
                  snapshot.data?['current']['relative_humidity_2m'] ?? 'N/A';
              final precipitation =
                  snapshot.data?['current']['precipitation'] ?? 'N/A';
              final rain = snapshot.data?['current']['rain'] ?? 'N/A';
              final locationName = '${location['city']}, ${location['region']}';

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.wb_sunny,
                        size: 64,
                        color: Colors.yellow,
                      ),
                      Text(
                        'Current Weather',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.location_on,
                        size: 24,
                        color: Colors.blue,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Location: ${utf8.decode(locationName.codeUnits)}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontFamily: 'Roboto',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.thermostat_outlined,
                        size: 24,
                        color: Colors.blue,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Temperature: $currentTemperature°C',
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.air,
                        size: 24,
                        color: Colors.blue,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Wind Speed: $windSpeed m/s',
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.water,
                        size: 24,
                        color: Colors.blue,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Humidity: $relativeHumidity%',
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.storm_rounded,
                        size: 24,
                        color: Colors.blue,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Precipitation: $precipitation mm',
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
