import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GeocodingService {
  Future<LatLng?> getCoordinatesFromQuery(String query) async {
    try {
      final addresses = await locationFromAddress(query);
      final firstAddress = addresses.first;
      return LatLng(firstAddress.latitude, firstAddress.longitude);
    } catch (e) {
      print('Error fetching coordinates: $e');
      return null;
    }
  }
}
