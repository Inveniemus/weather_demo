import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:weather_demo/blocs/weather_bloc.dart';

void main() {
  blocTest(
    'Test of current weather with connectivity',
    build: () => WeatherBloc(),
    act: (WeatherBloc bloc) => bloc.add(CurrentWeatherRequest(44.4, 5.08)),
    expect: () => [isA<CurrentWeatherState>()],
  );

  blocTest('Test of weather with bad parameters',
      build: () => WeatherBloc(),
      act: (WeatherBloc bloc) =>
          bloc.add(CurrentWeatherRequest(200.4, 300.08)),
    expect: () => [isA<UnknownWeatherState>()]
  );
}
