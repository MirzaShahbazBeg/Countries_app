import 'dart:convert';

import 'package:http/http.dart' as http;

import './weather_model.dart';

class WeatherService {
  Future<weatherResponse> getWeather(String city) async {
//https://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={API key}

    final queryParameters = {
      'q': city,
      'appid': '72716d065b2e367d6c8ce4e82a4a3f42',
      'units': 'metric'
    };
    final uri = Uri.https(
        'api.openweathermap.org', '/data/2.5/weather', queryParameters);
    final response = await http.get(uri);

    final json = jsonDecode(response.body);
    return weatherResponse.fromJson(json);
  }
}
