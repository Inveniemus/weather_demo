import 'dart:convert' show jsonDecode;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class OpenWeatherApiClient {
  final client = http.Client();
  static const String apiKey = '642c93fe9a80e2acfd567eede699b9f4';

  // End points
  static const String currentWeatherEndPoint =
      'api.openweathermap.org/data/2.5/weather?';

  // On errors, returns an empty Map.
  Future<Map<String, dynamic>> getCurrentWeatherAtLatLon(
      double latitude, double longitude) async {
    final uri = _buildUri(LocationRequestMode.lat_lon,
        latitude: latitude, longitude: longitude);

    try {
      // todo: check for connectivity
      final response = await client.get(uri);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
    } on Exception catch(exception) {
      // todo deal with it properly
      print('[OpenWeatherAPI ERROR:]${exception.toString()}');
    }
    return {};
  }

  Uri _buildUri(LocationRequestMode locationRequestMode,
      {double? latitude, double? longitude, String? cityName}) {
    String locationRequest() {
      switch (locationRequestMode) {
        case LocationRequestMode.lat_lon:
          assert(latitude != null && longitude != null);
          return 'lat=$latitude&lon=$longitude';
        case LocationRequestMode.city:
          return 'q=$cityName';
      }
    }

    return Uri.parse('https://$currentWeatherEndPoint'
        '${locationRequest()}'
        '&appid=$apiKey');
  }

  @visibleForTesting
  String buildUriString(LocationRequestMode locationRequestMode,
          {double? latitude, double? longitude, String? cityName}) =>
      _buildUri(locationRequestMode, latitude: latitude, longitude: longitude)
          .toString();
}

enum LocationRequestMode {
  lat_lon,
  city,
}
