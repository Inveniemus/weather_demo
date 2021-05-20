import 'package:bloc_test/bloc_test.dart';
import 'package:geolocator/geolocator.dart' show Position;
import 'package:weather_demo/blocs/geolocation_bloc.dart';

void main() {
  final aPosition = Position(
      longitude: 30.6,
      latitude: 50.1,
      timestamp: DateTime(1991),
      accuracy: 50.0,
      altitude: 200.0,
      heading: 270,
      speed: 0,
      speedAccuracy: 10);

  blocTest(
    'Test with a fetched position',
    build: () => GeolocationBloc(),
    act: (GeolocationBloc bloc) => bloc.add(LocationRequest()),
    expect: () => [WaitingForPosition()],
  );
}
