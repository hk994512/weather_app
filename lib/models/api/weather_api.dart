import 'dart:convert';

import 'package:http/http.dart' as http;

import '../data/weather_data.dart';

class WeatherApi {
  static const String _apiKey = 'YOUR_API_KEY';
  static const String _baseUrl =
      'https://api.openweathermap.org/data/2.5/weather';

  static Future<WeatherData> fetchWeather(String cityName) async {
    final response = await http.get(
      Uri.parse('$_baseUrl?q=$cityName&units=metric&appid=$_apiKey'),
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return WeatherData.fromJson(json);
    } else if (response.statusCode == 404) {
      throw Exception('City not found');
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
