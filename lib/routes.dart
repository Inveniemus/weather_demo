import 'package:flutter/material.dart';
import 'package:weather_demo/pages/settings_page.dart';
import 'package:weather_demo/pages/weather_demo_home.dart';
import 'package:weather_demo/utils/errors.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => WeatherDemoHome());
      case '/settings':
        return MaterialPageRoute(builder: (_) => SettingsPage());
      default:
        throw RouteError('Unknown route ${settings.name}');
    }
  }
}
