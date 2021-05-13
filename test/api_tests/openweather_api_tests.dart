import 'package:flutter_test/flutter_test.dart';

import 'package:weather_demo/weather_api/openweather_api.dart';

void main() async {
  test('Uri builder', () {
    final client = OpenWeatherApiClient();
    expect(
        client.buildUriString(
          LocationRequestMode.lat_lon, latitude: 30.0, longitude: 30.0),
          'https://api.openweathermap.org/data/2.5/weather?'
              'lat=30.0&lon=30.0&appid=642c93fe9a80e2acfd567eede699b9f4');
  });

  test('Get weather at 20, 20', () async {
    final client = OpenWeatherApiClient();
    final data = await client.getCurrentWeatherAtLatLon(44.4, 5.08);
    expect(data['name'], 'Nyons');
  });
}