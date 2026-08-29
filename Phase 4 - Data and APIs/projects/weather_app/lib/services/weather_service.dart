import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather_model.dart';

class WeatherService {
  // i make it simple: Hardcoded data for Dhaka coordinate
  static const double _latitude = 23.8103;
  static const double _longitude = 90.4125;

  static const String _baseUrl = 'https://api.open-meteo.com/v1/forecast';

  Future<WeatherModel> fetchWeather() async {
    final url = Uri.parse(
      '$_baseUrl?latitude=$_latitude&longitude=$_longitude&current_weather=true',  //open-meteo accept latitude and longitude 
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return WeatherModel.fromJson(data);
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}