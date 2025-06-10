class WeatherEntity {
  final String city;
  final double temperature;
  final String description;
  final String icon;
  final int humidity;       // влажность, %
  final double windSpeed;   // скорость ветра, м/с
  final int pressure;       // давление, гПа

  WeatherEntity({
    required this.city,
    required this.temperature,
    required this.description,
    required this.icon,
    required this.humidity,
    required this.windSpeed,
    required this.pressure,
  });
}
