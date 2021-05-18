part of 'home_navigation_bloc.dart';

abstract class NavigationState {
  const NavigationState();
}

class NavToLanding extends NavigationState {}
class NavToCurrentWeather extends NavigationState {}
class NavToSettings extends NavigationState {}
class NavToApiDebug extends NavigationState {}