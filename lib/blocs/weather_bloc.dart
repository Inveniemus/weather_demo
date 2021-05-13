import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_demo/domain/weather.dart';
import 'package:weather_demo/weather_api/openweather_api.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(UnknownWeatherState());

  Weather? currentWeather;
  final client = OpenWeatherApiClient();

  @override
  Stream<WeatherState> mapEventToState(
    WeatherEvent event,
  ) async* {
    if (event is CurrentWeatherRequest) {
      if (currentWeather == null || (currentWeather!.time != null &&
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
  }

  bool _isMoreThan10MinutesOld(DateTime time) {
    return DateTime.now().isAfter(time.add(Duration(minutes: 10)));
  }
}
