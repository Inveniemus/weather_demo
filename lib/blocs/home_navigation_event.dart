part of 'home_navigation_bloc.dart';

abstract class NavigationEvent {
  const NavigationEvent();
}

class LandingNavEvent extends NavigationEvent {}
class SettingsNavEvent extends NavigationEvent {}
class CurrentWeatherNavEvent extends NavigationEvent {}
class ApiDebugNavEvent extends NavigationEvent {}
