import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'blocs/weather_bloc.dart';
import 'blocs/home_navigation_bloc.dart';
import 'weather_demo_app.dart';

void main() {
  runApp(WeatherDemo());
}

class WeatherDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MultiBlocProvider(
        providers: [
          BlocProvider<WeatherBloc>(create: (context) => WeatherBloc()),
          BlocProvider<NavigationBloc>(create: (context) => NavigationBloc()),
        ],
        child: WeatherDemoApp()),
    );
  }
}
