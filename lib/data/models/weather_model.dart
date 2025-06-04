import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/weather_entity.dart';

part 'weather_model.g.dart';

@JsonSerializable()
class WeatherModel {
  final MainInfo main;
  final List<WeatherInfo> weather;

  WeatherModel({required this.main, required this.weather});

  factory WeatherModel.fromJson(Map<String, dynamic> json) => _$WeatherModelFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherModelToJson(this);

  WeatherEntity toEntity() {
    return WeatherEntity(
      temperature: main.temp,
      description: weather.first.description,
      icon: weather.first.icon,
    );
  }
}

@JsonSerializable()
class MainInfo {
  final double temp;
  MainInfo({required this.temp});

  factory MainInfo.fromJson(Map<String, dynamic> json) => _$MainInfoFromJson(json);
  Map<String, dynamic> toJson() => _$MainInfoToJson(this);
}

@JsonSerializable()
class WeatherInfo {
  final String description;
  final String icon;
  WeatherInfo({required this.description, required this.icon});

  factory WeatherInfo.fromJson(Map<String, dynamic> json) => _$WeatherInfoFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherInfoToJson(this);
}
