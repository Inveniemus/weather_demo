import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/weather_bloc.dart';
import '../domain/weather.dart';

/// This widget checks a OpenWeather API BLoC message to display received data.
class OpenWeatherApiDebugWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: _ExpansionList([
          {'header': _HeaderTitle('WEATHER DATA:'), 'body': _WeatherData()},
          {'header': _HeaderTitle('OPENWEATHER API RAW DATA:'), 'body': _ApiRawData()},
          {'header': _HeaderTitle('RAW MESSAGE:'), 'body': _RawMessage()}
        ])
    );
  }
}

class _ExpansionList extends StatefulWidget {

  final List<Map<String, Widget>> _widgetsData;

  _ExpansionList(this._widgetsData) {
    assert(_widgetsData.any((element) =>
        element.keys.any((key) => key == 'header' || key == 'body')));
  }

  int get length => _widgetsData.length;

  Widget headerAt(int index) => _widgetsData[index]['header']!;

  Widget bodyAt(int index) => _widgetsData[index]['body']!;

  @override
  _ExpansionListState createState() => _ExpansionListState();
}

class _ExpansionListState extends State<_ExpansionList> {

  List<int> _expandedItemsIndexes = [];

  void _stateCallback(int index, bool isExpanded) {
    if (isExpanded) {
      _expandedItemsIndexes.remove(index);
    } else {
      if (!_expandedItemsIndexes.contains(index)) {
        _expandedItemsIndexes.add(index);
      }
    }
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
        expansionCallback: _stateCallback,
        children: List<ExpansionPanel>.generate(widget.length, (index) =>
            ExpansionPanel(
              isExpanded: _expandedItemsIndexes.contains(index),
              headerBuilder: (context, isExpanded) => widget.headerAt(index),
              body: widget.bodyAt(index),
            ),
        )
    );
  }
}

class _HeaderTitle extends StatelessWidget {
  final String _title;

  _HeaderTitle(this._title);

  @override
  Widget build(BuildContext context) {
    return Text(
      _title,
      style: Theme.of(context).textTheme.headline6,
      textAlign: TextAlign.center,
    );
  }
}

class _RawMessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(builder: (context, state) {
      if (state is FetchingWeatherState) {
        return Center(child: CircularProgressIndicator(),);
      } else if (state is CurrentWeatherState) {
        return Text(state.weather.rawData.toString());
      }
      return Text('ERROR');
    });
  }
}

class _ApiRawData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(builder: (context, state) {
      if (state is FetchingWeatherState) {
        return Center(child: CircularProgressIndicator(),);
      } else if (state is CurrentWeatherState) {
        return Column(children: _processKeys(state.weather.rawData!, 0),);
      }
      return Text('ERROR');
    });
  }

  List<Widget> _processKeys(Map<String, dynamic> data, int level) {
    final widgets = <Widget>[];
    final leadingStringB = '- ' * level * 2;

    data.keys.forEach((key) {
      if (data[key] is Map<String, dynamic>) {
        widgets.add(ListTile(title: Text('$leadingStringB $key'),));
        widgets.addAll(_processKeys(data[key], level + 1));
      } else if (data[key] is List) {
        widgets.add(ListTile(title: Text('$leadingStringB $key'),));
        data[key]
            .forEach((item) => widgets.addAll(_processKeys(item, level + 1)));
      } else {
        widgets.add(ListTile(
          title: Text('$leadingStringB $key'),
          trailing: Text('${data[key]}'),
        ));
      }
    });
    return widgets;
  }
}

class _WeatherData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(builder: (context, state) {
      if (state is FetchingWeatherState) {
        return Center(child: CircularProgressIndicator(),);
      } else if (state is CurrentWeatherState) {
        return Column(children: _processWeatherValues(state.weather),);
      }
      return Text('ERROR');
    });
  }

  List<Widget> _processWeatherValues(Weather weather) {
    final widgets = <Widget>[];

    widgets.add(_ApiValueItem('At (Latitude, Longitude)', '${weather.latitude}, ${weather.longitude}'));
    widgets.add(_ApiValueItem('near:', weather.cityName));
    widgets.add(_ApiValueItem('Time stamp:', weather.time));
    widgets.add(Divider());
    widgets.add(_ApiValueItem('Weather main condition:', weather.conditionMain,
        _getWeatherMainConditionImage(weather.conditionMain, weather.conditionDescription)));
    widgets.add(_ApiValueItem('Weather description:', weather.conditionDescription));
    widgets.add(Divider());
    widgets.add(_ApiValueItem('Temperature:', weather.temperature));
    widgets.add(_ApiValueItem('Feels like:', weather.feelsLikeTemperature));
    widgets.add(_ApiValueItem('Pressure (sea level):', weather.seaLevelPressure ?? weather.pressure));
    widgets.add(_ApiValueItem('Humidity:', weather.humidity));
    widgets.add(Divider());
    widgets.add(_ApiValueItem('Wind speed:', weather.windSpeed));
    widgets.add(_ApiValueItem('Wind direction (from):', weather.windDirection));
    widgets.add(_ApiValueItem('Wind gusts:', weather.windGust));
    widgets.add(Divider());
    widgets.add(_ApiValueItem('Visibility:', weather.visibility));
    widgets.add(_ApiValueItem('Cloudiness:', '${weather.cloudiness}%'));

    return widgets;
  }

  Image _getWeatherMainConditionImage(String? condition, String? description) {
    switch (condition) {
      case 'Clear':
        return Image(image: AssetImage('graphics/weather_images/039-sun.png'),);
      case 'few clouds':
        return Image(image: AssetImage('graphics/weather_images/038-cloudy-3.png'),);
      case 'scattered clouds':
        return Image(image: AssetImage('graphics/weather_images/038-cloudy-3.png'),);
      case 'Clouds':
        switch (description) {
          case 'few clouds':
            return Image(image: AssetImage('graphics/weather_images/038-cloudy-3.png'),);
          case 'scattered clouds':
            return Image(image: AssetImage('graphics/weather_images/038-cloudy-3.png'),);
          case 'broken clouds':
            return Image(image: AssetImage('graphics/weather_images/001-cloud.png'),);
          case 'overcast clouds':
            return Image(image: AssetImage('graphics/weather_images/011-cloud.png'),);
          default:
            return Image(image: AssetImage('graphics/weather_images/001-cloud.png'),);
        }
      case 'Rain':
        return Image(image: AssetImage('graphics/weather_images/004-rainy-1.png'),);
      case 'Drizzle':
        return Image(image: AssetImage('graphics/weather_images/003-rainy.png'),);
      case 'Thunderstorm':
        return Image(image: AssetImage('graphics/weather_images/008-storm.png'),);
      case 'Snow':
        return Image(image: AssetImage('graphics/weather_images/006-snowy.png'),);
      case 'mist':
        return Image(image: AssetImage('graphics/weather_images/050-windy-3.png'),);
      default:
        return Image(image: AssetImage('graphics/weather_images/039-sun.png'),);
    }
  }
}

class _ApiValueItem extends StatelessWidget {
  final String fieldPath;
  final dynamic value;
  final Image? _image;

  _ApiValueItem(this.fieldPath, this.value, [this._image]);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: _image,
      title: Text(fieldPath),
      trailing: Text((value ?? 'NONE').toString()),
    );
  }
}
