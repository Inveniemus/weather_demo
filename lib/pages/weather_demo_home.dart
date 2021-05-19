import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../utils/api_debug_widget.dart';
import '../blocs/home_navigation_bloc.dart';
import 'settings_page.dart';
import '../widgets/current_weather_widget.dart';
import '../blocs/weather_bloc.dart';

/// Example of BLoC use instead of Stateful widget
class WeatherDemoHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
      BlocProvider.of<WeatherBloc>(context)
          .add(CurrentWeatherRequest(44.4, 5.08));
    });

    int _getCurrentIndex(NavigationState state) {
      if (state is NavToCurrentWeather) return 1;
      if (state is NavToApiDebug) return 2;
      if (state is NavToSettings) return 3;
      return 0;
    }

    Widget _selectWidget(NavigationState state) {
      if (state is NavToCurrentWeather) return CurrentWeatherWidget();
      if (state is NavToApiDebug) return OpenWeatherApiDebugWidget();
      if (state is NavToSettings) return SettingsBody();
      return CurrentWeatherWidget();
    }

    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Center(child: Text('Weather Demo')),
          ),
          body: _selectWidget(state),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.blueGrey,
            type: BottomNavigationBarType.fixed,
            currentIndex: _getCurrentIndex(state),
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.wb_sunny), label: 'Current Weather'),
              BottomNavigationBarItem(icon: Icon(Icons.account_tree_outlined), label: 'API Debug'),
              BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
            ],
            onTap: (int index) {
              switch (index) {
                case 1:
                  BlocProvider.of<NavigationBloc>(context).add(CurrentWeatherNavEvent());
                  break;
                case 2:
                  BlocProvider.of<NavigationBloc>(context).add(ApiDebugNavEvent());
                  break;
                case 3:
                  BlocProvider.of<NavigationBloc>(context).add(SettingsNavEvent());
                  break;
                default:
                  BlocProvider.of<NavigationBloc>(context).add(LandingNavEvent());
              }
            },
          ),
        );
      });
  }
}
