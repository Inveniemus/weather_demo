import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_demo/providers.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Settings'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [ThemeColorSettingItem()],
          ),
        ));
  }
}

class ThemeColorSettingItem extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return Row(
      children: [
        Expanded(child: Text("Theme's color:")),
        ElevatedButton(
          onPressed: () => watch(themeProvider.notifier).pinkify(),
          style: ElevatedButton.styleFrom(
            primary: Colors.pink,
          ),
          child: Text(''),
        ),
        ElevatedButton(
          onPressed: () => watch(themeProvider.notifier).setDefault(),
          style: ElevatedButton.styleFrom(
            primary: Colors.blue,
          ),
          child: Text(''),
        ),
      ],
    );
  }
}
