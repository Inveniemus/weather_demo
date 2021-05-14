import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/weather_bloc.dart';
import '../domain/weather.dart';

/// This widget checks a OpenWeather API BLoC message to display received raw
/// data.
class OpenWeatherApiDebugWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        if (state is CurrentWeatherState) {
          return _buildListView(state.weather, context);
        } else if (state is FetchingWeatherState) {
          return CircularProgressIndicator();
        }
        return Text('NO INFO');
      },
    );
  }

  Widget _buildListView(Weather weather, BuildContext context) {
    final widgets = <Widget>[];
    final Map<String, dynamic> data = weather.rawData!;

    widgets.add(
      Text(
        'OPENWEATHER API RAW DATA:',
        style: Theme.of(context).textTheme.headline6,
        textAlign: TextAlign.center,
      ),
    );
    widgets.addAll(_processKeys(data, 0));
    widgets.add(
      Text(
        'RAW MESSAGE:',
        style: Theme.of(context).textTheme.headline6,
        textAlign: TextAlign.center,
      ),
    );
    widgets.add(Text(data.toString()));

    return ListView(
      children: widgets,
    );
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

class ApiValueItem extends StatelessWidget {
  final String fieldPath;
  final dynamic value;

  ApiValueItem(this.fieldPath, this.value);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(fieldPath),
      trailing: Text(value),
    );
  }
}
