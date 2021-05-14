import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_demo/utils/api_debug_widget.dart';

import '../buttons/settings_button.dart';
import '../blocs/weather_bloc.dart';

class WeatherDemoHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
      BlocProvider.of<WeatherBloc>(context)
          .add(CurrentWeatherRequest(44.4, 5.08));
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Weather Demo'),
        actions: [
          SettingsButton(),
        ],
      ),
      body: OpenWeatherApiDebugWidget(),
    );
  }
}
