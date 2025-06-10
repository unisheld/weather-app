import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/constants.dart';
import '../models/weather_model.dart';

class WeatherRemoteDataSource {
  Future<WeatherModel> fetchWeather(String city) async {

    
    final apiKey = AppConstants.weatherApiKey;

    if (apiKey.isEmpty) {
      throw Exception('API key is not set. Передайте ключ через --dart-define=key=твой ключ');
    }    
    final url = 'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric&lang=ru';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return WeatherModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Ошибка при получении погоды');
    }
  }
}
