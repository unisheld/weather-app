import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather_model.dart';

class WeatherRemoteDataSource {
  final _apiKey = 'your_api_key_here'; // ApiKey openweathermap

  Future<WeatherModel> fetchWeather(String city) async {
    final url = 'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$_apiKey&units=metric&lang=ru';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return WeatherModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Ошибка при получении погоды');
    }
  }
}