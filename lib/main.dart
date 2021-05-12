import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_demo/pages/weather_demo_home.dart';


void main() {
  runApp(WeatherDemoApp());
}

class WeatherDemoApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return ProviderScope(

      child: WeatherDemoHome(),
    );
  }
}
