import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_demo/pages/weather_demo_home.dart';
import 'package:weather_demo/routes.dart';

import 'providers.dart';

class WeatherDemoApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final themeData = watch(themeProvider);

    return MaterialApp(
        title: 'Weather Demo',
        theme: themeData,
        initialRoute: '/',
        onGenerateRoute: RouteGenerator.generateRoute,
        home: WeatherDemoHome(),
    );
  }
}
