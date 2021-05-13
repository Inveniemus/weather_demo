part of 'weather_bloc.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();
}

class UnknownWeatherState extends WeatherState {
  @override
  List<Object> get props => [];
}

class FetchingWeatherState extends WeatherState {
  @override
  List<Object> get props => [];
}

class CurrentWeatherState extends WeatherState {

  final Weather weather;
  CurrentWeatherState(this.weather);

  @override
  List<Object?> get props => [weather.time];
}
