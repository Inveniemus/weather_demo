import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/weather_bloc.dart';

class CurrentWeatherWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              UpperWeatherWidget(state),
              LowerWeatherWidget(state),
            ],
          ),
        );
      },
    );
  }
}

class UpperWeatherWidget extends StatelessWidget {

  final WeatherState _state;
  UpperWeatherWidget(this._state);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.orange,
      child: Text('Upper'),
    );
  }
}

class LowerWeatherWidget extends StatelessWidget {

  final WeatherState _state;
  LowerWeatherWidget(this._state);

  String _buildString() {
    String near = '???';
    String at = '???';
    if (_state is CurrentWeatherState) {
      final weatherState = _state as CurrentWeatherState;
      near = weatherState.weather.cityName ?? '???';
      if (weatherState.weather.time != null) {
        at = weatherState.weather.time!.toIso8601String().substring(11, 16);
      } else {
        at = '???';
      }
    }
    return 'near $near at $at';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(_buildString()),
      ),
    );
  }
}
