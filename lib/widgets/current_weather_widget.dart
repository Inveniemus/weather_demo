import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/weather_bloc.dart';
import '../blocs/geolocation_bloc.dart';
import 'weather_image.dart';

class CurrentWeatherWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
      BlocProvider.of<GeolocationBloc>(context)
          .add(LocationRequest());
    });

    return SingleChildScrollView(
      child: BlocListener<GeolocationBloc, GeolocationState>(
        listener: (context, state) {
          if (state is PositionState) {
            BlocProvider.of<WeatherBloc>(context).add(
              CurrentWeatherRequest(state.position.latitude, state.position.longitude)
            );
          }
        },
        child: BlocBuilder<WeatherBloc, WeatherState>(
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
        ),
      ),
    );
  }
}

class UpperWeatherWidget extends StatelessWidget {

  final WeatherState _state;

  UpperWeatherWidget(this._state);

  Widget get _weatherImage {
    if (_state is CurrentWeatherState) {
      final weather = (_state as CurrentWeatherState).weather;
      if (weather.conditions.isNotEmpty) {
        return WeatherImage(weather.conditions.first);
      } else {
        return Text('NO WX');
      }
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
      return (_state as CurrentWeatherState).weather.feelsLikeTemperature
          .toString();
    } else {
      return '??';
    }
  }

  Widget get _windIcon {
    final icon = Icon(Icons.arrow_right_alt, color: Colors.red, size: 50,);
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
      String returnString = '';
      if (weather.windSpeed != null) {
        final kmh = (weather.windSpeed! * 3.6).round();
        returnString += '$kmh km/h';
        if (weather.windGust != null) {
          final gusts = (weather.windGust! * 3.6).round();
          returnString += '\nmax $gusts km/h';
        }
      }
      return returnString;
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
              Text('feels like $_feelsLikeString °C', textScaleFactor: 1.5,
                style: TextStyle(fontStyle: FontStyle.italic),),
              Row(
                children: [
                  Padding(padding: EdgeInsets.all(8.0), child: _windIcon),
                  Text(_windSpeed, textAlign: TextAlign.center, textScaleFactor: 1.5,),
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

  String _buildWeatherDescription() {
    String weatherString = 'Weather: ???';
    if (_state is CurrentWeatherState) {
      final weather = (_state as CurrentWeatherState).weather;
      weatherString = 'Weather: ';
      weather.conditions.forEach((condition) {
        weatherString += condition.conditionDescription ?? '';
        weatherString += ', ';
      });
    }
    return weatherString.substring(0, weatherString.length - 2);
  }

  String _buildLocationString() {
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
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(_buildWeatherDescription(), textScaleFactor: 1.5,),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(_buildLocationString(), textScaleFactor: 1.5,),
          ),
        ],
      ),
    );
  }
}
