import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:my_weather/services/weather.service.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  Color getTemperatureColor(double temp) {
    if (temp < 20) {
      return Colors.blue;
    } else if (temp < 25) {
      return Colors.green;
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
          future: GetIt.instance<WeatherService>().fetchWeatherData(),
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
                  snapshot.data?['current']['temperature_2m'];
              final windSpeed = snapshot.data?['current']['wind_speed_10m'];
              final relativeHumidity =
                  snapshot.data?['current']['relative_humidity_2m'];

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Current Weather',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const FaIcon(
                        FontAwesomeIcons.thermometer,
                        size: 24,
                        color: Colors.blue,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '$currentTemperature°C',
                        style: TextStyle(
                          fontSize: 36,
                          color: getTemperatureColor(currentTemperature),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const FaIcon(
                        FontAwesomeIcons.wind,
                        size: 24,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Wind speed: $windSpeed km/h',
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const FaIcon(
                        FontAwesomeIcons.water,
                        size: 24,
                        color: Colors.blue,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '$relativeHumidity%',
                        style: const TextStyle(
                          fontSize: 36,
                          color: Colors.blue,
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
