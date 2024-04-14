import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_weather/services/ip.service.dart';
import 'package:http/http.dart' as http;

class GeocodingService extends GeocodingPlatform {
  final IpService ipService = GetIt.instance<IpService>();

  Future<LatLng?> getCoordinatesFromIpAddress(String ipAddress) async {
    try {
      final approximateCoordinates = await getApproximateCoordinates(ipAddress);

      final refinedCoordinates = null;
      
      return refinedCoordinates ?? approximateCoordinates;
    } catch (e) {
      print('Error fetching coordinates: $e');
      return null;
    }
  }

  Future<LatLng?> getApproximateCoordinates(String ipAddress) async {
    try {
      final apiKey = '2c5525575c1946ad9fad47e296e71bb4';
      final response = await http.get(Uri.parse(
          'https://api.ipgeolocation.io/ipgeo?apiKey=$apiKey&ip=$ipAddress'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final latitude = data['latitude'] as double;
        final longitude = data['longitude'] as double;
        return LatLng(latitude, longitude);
      } else {
        throw Exception('Failed to load approximate coordinates');
      }
    } catch (e) {
      print('Error fetching approximate coordinates: $e');
      return null;
    }
  }
}
