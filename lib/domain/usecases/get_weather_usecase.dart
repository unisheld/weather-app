import '../entities/weather_entity.dart';
import '../repositories/weather_repository.dart';

class GetWeatherUseCase {
  final WeatherRepository repository;

  GetWeatherUseCase(this.repository);

  Future<WeatherEntity> call(String city) {
    return repository.getWeather(city);
  }
}