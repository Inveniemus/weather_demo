part of 'weather_bloc.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();
}

class CurrentWeatherRequest extends WeatherEvent {
  final double latitude;
  final double longitude;
  CurrentWeatherRequest(this.latitude, this.longitude);

  @override
  List<Object?> get props => [latitude, longitude];
}
