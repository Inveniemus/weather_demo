part of 'geolocation_bloc.dart';

abstract class GeolocationState extends Equatable {
  const GeolocationState();
}

class GeolocationInitial extends GeolocationState {
  @override
  List<Object> get props => [];
}

class WaitingForPosition extends GeolocationState {
  @override
  List<Object> get props => [];
}

class PositionState extends GeolocationState {
  final Position position;

  PositionState(this.position);

  @override
  List<Object?> get props => [position.latitude, position.longitude];
}
