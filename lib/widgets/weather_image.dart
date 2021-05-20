import 'package:flutter/material.dart';

import '../domain/weather.dart';

class WeatherImage extends StatelessWidget {

  final Weather _weather;
  WeatherImage(this._weather);

  @override
  Widget build(BuildContext context) {
    switch (_weather.conditionMain) {
      case 'Clear':
        return Image(image: AssetImage('graphics/weather_images/039-sun.png'),);
      case 'few clouds':
        return Image(image: AssetImage('graphics/weather_images/038-cloudy-3.png'),);
      case 'scattered clouds':
        return Image(image: AssetImage('graphics/weather_images/038-cloudy-3.png'),);
      case 'Clouds':
        switch (_weather.conditionDescription) {
          case 'few clouds':
            return Image(image: AssetImage('graphics/weather_images/038-cloudy-3.png'),);
          case 'scattered clouds':
            return Image(image: AssetImage('graphics/weather_images/038-cloudy-3.png'),);
          case 'broken clouds':
            return Image(image: AssetImage('graphics/weather_images/001-cloud.png'),);
          case 'overcast clouds':
            return Image(image: AssetImage('graphics/weather_images/011-cloud.png'),);
          default:
            return Image(image: AssetImage('graphics/weather_images/001-cloud.png'),);
        }
      case 'Rain':
        return Image(image: AssetImage('graphics/weather_images/004-rainy-1.png'),);
      case 'Drizzle':
        return Image(image: AssetImage('graphics/weather_images/003-rainy.png'),);
      case 'Thunderstorm':
        return Image(image: AssetImage('graphics/weather_images/008-storm.png'),);
      case 'Snow':
        return Image(image: AssetImage('graphics/weather_images/006-snowy.png'),);
      case 'mist':
        return Image(image: AssetImage('graphics/weather_images/050-windy-3.png'),);
      default:
        return Image(image: AssetImage('graphics/weather_images/039-sun.png'),);
    }
  }
}
