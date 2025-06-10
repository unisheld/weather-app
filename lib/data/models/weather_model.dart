import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/weather_entity.dart';

part 'weather_model.g.dart';

@JsonSerializable()
class WeatherModel {
  final String name;
  final MainInfo main;
  final List<WeatherInfo> weather;
  final WindInfo wind;

  WeatherModel({
    required this.name,
    required this.main,
    required this.weather,
    required this.wind,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) => _$WeatherModelFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherModelToJson(this);

  WeatherEntity toEntity() {
    return WeatherEntity(      
      city: name,
      temperature: main.temp,
      description: weather.first.description,
      icon: weather.first.icon,
      humidity: main.humidity,
      windSpeed: wind.speed,
      pressure: main.pressure,
    );
  }
}

@JsonSerializable()
class MainInfo {  
  final double temp;
  final int humidity;
  final int pressure;

  MainInfo({
    required this.temp,
    required this.humidity,
    required this.pressure,
  });

  factory MainInfo.fromJson(Map<String, dynamic> json) => _$MainInfoFromJson(json);
  Map<String, dynamic> toJson() => _$MainInfoToJson(this);
}

@JsonSerializable()
class WeatherInfo {  
  final String description;
  final String icon;

  WeatherInfo({    
    required this.description,
    required this.icon,
  });

  factory WeatherInfo.fromJson(Map<String, dynamic> json) => _$WeatherInfoFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherInfoToJson(this);
}

@JsonSerializable()
class WindInfo {
  final double speed;

  WindInfo({
    required this.speed,
  });

  factory WindInfo.fromJson(Map<String, dynamic> json) => _$WindInfoFromJson(json);
  Map<String, dynamic> toJson() => _$WindInfoToJson(this);
}
