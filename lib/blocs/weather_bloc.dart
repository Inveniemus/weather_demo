import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../domain/weather.dart';
import '../weather_api/openweather_api.dart';

part 'weather_event.dart';

part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(UnknownWeatherState());

  Weather? currentWeather;
  final client = OpenWeatherApiClient();

  WeatherEvent? _previous;

  @override
  Stream<WeatherState> mapEventToState(
    WeatherEvent event,
  ) async* {
    if (event is CurrentWeatherRequest) {
      if (currentWeather == null ||
          _previous != event ||
          (currentWeather!.time != null &&
              _isMoreThan10MinutesOld(currentWeather!.time!))) {
        yield FetchingWeatherState();
        final data = await client.getCurrentWeatherAtLatLon(
            event.latitude, event.longitude);
        if (data.isNotEmpty) {
          currentWeather = Weather.fromMap(data);
        } else {
          currentWeather = null;
        }
      }

      if (currentWeather != null) {
        yield CurrentWeatherState(currentWeather!);
      } else {
        yield UnknownWeatherState();
      }
    }
    _previous = event;
  }

  bool _isMoreThan10MinutesOld(DateTime time) {
    return DateTime.now().isAfter(time.add(Duration(minutes: 10)));
  }
}
