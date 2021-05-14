import 'package:flutter_test/flutter_test.dart';
import 'package:weather_demo/domain/weather.dart';

void main() {
  group('Weather fromMap constructor', () {
    final weather = Weather.fromMap({
      'dt': 1035504000,
      'name': 'Nyons',
      'coord': {'lat': 44.4, 'lon': 5.08}
    });
    final aRealWeather = Weather.fromMap({
      'coord': {'lon': 5.08, 'lat': 44.4},
      'weather': [
        {
          'id': 802,
          'main': 'Clouds',
          'description': 'scattered clouds',
          'icon': '03d'
        }
      ],
      'base': 'stations',
      'main': {
        'temp': 288.94,
        'feels_like': 288.09,
        'temp_min': 288.05,
        'temp_max': 289.81,
        'pressure': 1011,
        'humidity': 58,
        'sea_level': 1011,
        'grnd_level': 961
      },
      'visibility': 10000,
      'wind': {'speed': 6.42, 'deg': 341, 'gust': 9.22},
      'clouds': {'all': 28},
      'dt': 1620904955,
      'sys': {
        'type': 2,
        'id': 2000063,
        'country': 'FR',
        'sunrise': 1620879282,
        'sunset': 1620932249
      },
      'timezone': 7200,
      'id': 2989819,
      'name': 'Nyons',
      'cod': 200
    });

    test('UNIX timestamp conversion correctness', () {
      expect(weather.time?.toUtc(), DateTime.utc(2002, 10, 25));
    });

    test('Location data', () {
      expect(weather.longitude, 5.08);
      expect(weather.latitude, 44.4);
      expect(weather.cityName, 'Nyons');
    });

    test('aRealWeather check', () {
      expect(aRealWeather.temperature, 288.94 - 273.15);
      expect(aRealWeather.feelsLikeTemperature, 288.09 - 273.15);
      expect(aRealWeather.pressure, 1011);
      expect(aRealWeather.seaLevelPressure, 1011);
      expect(aRealWeather.groundLevelPressure, 961);
      expect(aRealWeather.humidity, 58);
      expect(aRealWeather.visibility, 10000);
      expect(aRealWeather.cloudiness, 28);
      expect(aRealWeather.windDirection, 341);
      expect(aRealWeather.windSpeed, 6.42);
      expect(aRealWeather.windGust, 9.22);
      expect(aRealWeather.conditionCode, 802);
      expect(aRealWeather.conditionMain, 'Clouds');
      expect(aRealWeather.conditionDescription, 'scattered clouds');
      expect(aRealWeather.windSpeed, 6.42);
      expect(aRealWeather.windGust, 9.22);
    });
  });
}
