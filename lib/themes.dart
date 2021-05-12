import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemeNotifier extends StateNotifier<ThemeData> {
  ThemeNotifier() : super(ThemeData(primaryColor: Colors.blue));

  void pinkify() {
    state = ThemeData(primaryColor: Colors.pink);
  }

  void setDefault() {
    state = ThemeData(primaryColor: Colors.blue);
  }
}
