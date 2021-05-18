import 'dart:async';

import 'package:bloc/bloc.dart';

part 'home_navigation_event.dart';
part 'home_navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(NavToLanding());

  @override
  Stream<NavigationState> mapEventToState(
    NavigationEvent event,
  ) async* {
    if (event is LandingNavEvent) {
      yield NavToLanding();
    } else if (event is CurrentWeatherNavEvent) {
      yield NavToCurrentWeather();
    } else if (event is SettingsNavEvent) {
      yield NavToSettings();
    } else if (event is ApiDebugNavEvent) {
      yield NavToApiDebug();
    }
  }
}
