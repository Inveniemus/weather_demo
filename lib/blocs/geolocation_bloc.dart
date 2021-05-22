import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart' as Geo;

import '../domain/position.dart';

part 'geolocation_event.dart';
part 'geolocation_state.dart';

class GeolocationBloc extends Bloc<GeolocationEvent, GeolocationState> {
  GeolocationBloc() : super(GeolocationInitial());

  bool? _serviceEnabled;
  Geo.LocationPermission? _permission;

  @override
  Stream<GeolocationState> mapEventToState(
    GeolocationEvent event,
  ) async* {

    yield WaitingForPosition();

    try {
      if (_serviceEnabled == null) {
        _serviceEnabled = await Geo.Geolocator.isLocationServiceEnabled();
      }
    } on Exception {
      // On platforms other that iOS and Android
      // Stop the process and yield Nyons position
      yield PositionState(Position(44.4, 5.1));
      return;
    }

    if (_serviceEnabled!) {
      // todo: deal with it
    }

    if (_permission == null) {
      _permission = await Geo.Geolocator.checkPermission();
    }

    if (_permission == Geo.LocationPermission.denied) {
      _permission = await Geo.Geolocator.requestPermission();
      if (_permission == Geo.LocationPermission.denied) {
        // todo: user denied, deal with it!
      }
    }

    if (_permission == Geo.LocationPermission.deniedForever) {
      // todo: deal with it
    }

    if (event is LocationRequest) {
      final geoPosition = await Geo.Geolocator.getCurrentPosition();
      yield PositionState(Position(geoPosition.latitude, geoPosition.longitude));
    }
  }
}
