import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/weather_bloc.dart';
import 'weather_image.dart';

class CurrentWeatherWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
      BlocProvider.of<WeatherBloc>(context)
          .add(CurrentWeatherRequest(44.4, 5.08));
    });

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

  Widget get _weatherImage {
    if (_state is CurrentWeatherState) {
      return WeatherImage((_state as CurrentWeatherState).weather);
    } else {
      return CircularProgressIndicator();
    }
  }

  String get _temperatureString {
    if (_state is CurrentWeatherState) {
      return (_state as CurrentWeatherState).weather.temperature.toString();
    } else {
      return '??';
    }
  }

  String get _feelsLikeString {
    if (_state is CurrentWeatherState) {
      return (_state as CurrentWeatherState).weather.feelsLikeTemperature.toString();
    } else {
      return '??';
    }
  }

  Widget get _windIcon {
    final icon = Icon(Icons.arrow_right_alt, color: Colors.red,);
    if (_state is CurrentWeatherState) {
      final weather = (_state as CurrentWeatherState).weather;
      return Transform.rotate(
        angle: (weather.windDirection!.toDouble() + 90.0) * 3.1415 / 180,
        child: icon,
      );
    } else {
      return Text('?');
    }
  }

  String get _windSpeed {
    if (_state is CurrentWeatherState) {
      final weather = (_state as CurrentWeatherState).weather;
      final kmh = (weather.windSpeed! * 3.6).round();
      final gusts = (weather.windGust! * 3.6).round();
      return '$kmh km/h\nto: $gusts km/h';
    } else {
      return '??';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: _weatherImage,
            ),
          ),
          Column(
            children: [
              Text('$_temperatureString °C', textScaleFactor: 2,),
              Text('feels like $_feelsLikeString °C', textScaleFactor: 1.5, style: TextStyle(fontStyle: FontStyle.italic),),
              Row(
                children: [
                  Padding(padding: EdgeInsets.all(8.0),child: _windIcon),
                  Text(_windSpeed, textAlign: TextAlign.center,),
                ],
              ),
            ],
          )
        ],
      ),
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
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(_buildString(), textScaleFactor: 1.5,),
      ),
    );
  }
}
