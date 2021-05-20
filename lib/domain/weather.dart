import '../utils/numbers.dart';

class Weather {

  // Calculation Time
  DateTime? time;

  // Location
  double? latitude;
  double? longitude;
  
  // Weather conditions
  int? conditionCode;
  String? conditionMain;
  String? conditionDescription;

  // Parameters
  double? temperature;
  double? feelsLikeTemperature;
  int? pressure;
  int? seaLevelPressure;
  int? groundLevelPressure;
  int? humidity;

  // Wind
  double? windSpeed;
  int? windDirection;
  double? windGust;

  // Visibility
  int? visibility;

  // Clouds
  int? cloudiness;

  String? cityName;

  Map<String, dynamic>? rawData;

  Weather.fromMap(Map<String, dynamic> data) {

    rawData = data;

    if (data.containsKey('dt')) {
      time = DateTime.fromMillisecondsSinceEpoch(data['dt'] * 1000);
    }
    if (data.containsKey('coord')) {
      if (data['coord'].containsKey('lat') && data['coord'].containsKey('lat')) {
        latitude = data['coord']['lat'];
        longitude = data['coord']['lon'];
      }
    }
    if (data.containsKey('weather')) {
      if (data['weather'][0].containsKey('id')) conditionCode = data['weather'][0]['id'];
      if (data['weather'][0].containsKey('main')) conditionMain = data['weather'][0]['main'];
      if (data['weather'][0].containsKey('description')) conditionDescription = data['weather'][0]['description'];
    }
    if (data.containsKey('main')) {
      if (data['main'].containsKey('temp')) {
        temperature = roundDouble(data['main']['temp'] - 273.15, 1);
      }
      if (data['main'].containsKey('feels_like')) {
        feelsLikeTemperature = roundDouble(data['main']['feels_like'] - 273.15, 1);
      }
      if (data['main'].containsKey('pressure')) {
        pressure = data['main']['pressure'];
      }
      if (data['main'].containsKey('sea_level')) {
        seaLevelPressure = data['main']['sea_level'];
      }
      if (data['main'].containsKey('grnd_level')) {
        groundLevelPressure = data['main']['grnd_level'];
      }
      if (data['main'].containsKey('humidity')) {
        humidity = data['main']['humidity'];
      }
    }
    if (data.containsKey('wind')) {
      if (data['wind'].containsKey('speed')) windSpeed = data['wind']['speed'];
      if (data['wind'].containsKey('deg')) windDirection = data['wind']['deg'];
      if (data['wind'].containsKey('gust')) windGust = data['wind']['gust'];
    }
    if (data.containsKey('visibility')) visibility = data['visibility'];
    if (data.containsKey('clouds')) {
      if (data['clouds'].containsKey('all')) cloudiness = data['clouds']['all'];
    }
    if (data.containsKey('name')) {
      cityName = data['name'];
    }
  }
}