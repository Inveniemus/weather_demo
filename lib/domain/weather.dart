class Weather {

  // Calculation Time
  DateTime? time;

  // Location
  double? latitude;
  double? longitude;
  String? cityName;

  // Parameters
  double? temperature;
  double? feelsLikeTemperature;

  int? pressure;
  int? seaLevelPressure;
  int? groundLevelPressure;

  int? humidity;


  Weather.fromMap(Map<String, dynamic> data) {
    if (data.containsKey('dt')) {
      time = DateTime.fromMillisecondsSinceEpoch(data['dt'] * 1000);
    }
    if (data.containsKey('coord')) {
      if (data['coord'].containsKey('lat') && data['coord'].containsKey('lat')) {
        latitude = data['coord']['lat'];
        longitude = data['coord']['lon'];
      }
    }
    if (data.containsKey('name')) {
      cityName = data['name'];
    }
    if (data.containsKey('main')) {
      if (data['main'].containsKey('temp')) {
        temperature = data['main']['temp'] - 273.15;
      }
      if (data['main'].containsKey('feels_like')) {
        feelsLikeTemperature = data['main']['feels_like'] - 273.15;
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
  }
}