part of 'geolocation_bloc.dart';

abstract class GeolocationEvent extends Equatable {
  const GeolocationEvent();
}

class LocationRequest extends GeolocationEvent {
  @override
  List<Object?> get props => [];
}
