class WeatherModel{
  final double temperature;
  final double windspeed;
  final int weatherCode;

  WeatherModel({
    required this.temperature,
    required this.weatherCode,
    required this.windspeed,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    final currentWeather = json['current_weather'];
 
    return WeatherModel(
      temperature: currentWeather['temperature'].toDouble(),
      windspeed: currentWeather['windspeed'].toDouble(),
      weatherCode: currentWeather['weathercode'],
    );
  }
}