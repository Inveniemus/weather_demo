import 'package:flutter/material.dart';
import 'package:weather_demo/pages/settings_page.dart';
import 'package:weather_demo/weather_demo_app.dart';
import 'package:weather_demo/utils/errors.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => WeatherDemoApp());
      case '/settings':
        return MaterialPageRoute(builder: (_) => SettingsPage());
      default:
        throw RouteError('Unknown route ${settings.name}');
    }
  }
}
