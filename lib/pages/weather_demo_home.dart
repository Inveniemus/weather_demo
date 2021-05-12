import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_demo/routes.dart';

import '../providers.dart';
import '../buttons/settings_button.dart';

class WeatherDemoHome extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final themeData = watch(themeProvider);

    return MaterialApp(
        title: 'Weather Demo',
        theme: themeData,
        initialRoute: '/',
        onGenerateRoute: RouteGenerator.generateRoute,
        home: Scaffold(
          appBar: AppBar(
            title: Text('Weather Demo'),
            actions: [
              SettingsButton(),
            ],
          ),
          body: Column(
            children: [
              Text('test'),
            ],
          ),
        ));
  }
}
