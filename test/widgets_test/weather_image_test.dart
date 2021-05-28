import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

import 'package:weather_demo/domain/weather_condition.dart';
import 'package:weather_demo/widgets/weather_image.dart';

void main() {
  testWidgets(
      'WeatherImage widget shall be a sun if weather is empty',
      (WidgetTester tester) async {
    final widget = WeatherImage(WeatherCondition());
    await tester.pumpWidget(widget);
    final imageFinder = find.byType(Image);
    expect(imageFinder, findsOneWidget);
    expect(widget.imagePath, 'graphics/weather_images/039-sun.png');
  });
}
