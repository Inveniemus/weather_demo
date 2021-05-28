import 'package:flutter/material.dart';

import '../domain/weather_condition.dart';

class WeatherImage extends StatelessWidget {

  final String _imagePath;
  WeatherImage(WeatherCondition weather) : _imagePath = _getImagePath(weather.conditionMain, weather.conditionDescription);

  // null safe thanks to switch default cases!
  static String _getImagePath(String? weatherMain, String? weatherCondition) {
    switch (weatherMain) {
      case 'Clear':
        return 'graphics/weather_images/039-sun.png';
      case 'few clouds':
        return 'graphics/weather_images/038-cloudy-3.png';
      case 'scattered clouds':
        return 'graphics/weather_images/038-cloudy-3.png';
      case 'Clouds':
        switch (weatherCondition) {
          case 'few clouds':
            return 'graphics/weather_images/038-cloudy-3.png';
          case 'scattered clouds':
            return 'graphics/weather_images/038-cloudy-3.png';
          case 'broken clouds':
            return 'graphics/weather_images/001-cloud.png';
          case 'overcast clouds':
            return 'graphics/weather_images/011-cloudy.png';
          default:
            return 'graphics/weather_images/001-cloud.png';
        }
      case 'Rain':
        return 'graphics/weather_images/004-rainy-1.png';
      case 'Drizzle':
        return 'graphics/weather_images/003-rainy.png';
      case 'Thunderstorm':
        return 'graphics/weather_images/008-storm.png';
      case 'Snow':
        return 'graphics/weather_images/006-snowy.png';
      case 'mist':
        return 'graphics/weather_images/050-windy-3.png';
      default:
        return 'graphics/weather_images/039-sun.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Image(image: AssetImage(_imagePath),);
  }

  @visibleForTesting
  String get imagePath => _imagePath;
}
