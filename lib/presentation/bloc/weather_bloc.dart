import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_weather_usecase.dart';
import '../../domain/entities/weather_entity.dart';

sealed class WeatherEvent {}
class FetchWeather extends WeatherEvent {
  final String city;
  FetchWeather(this.city);
}

sealed class WeatherState {}
class WeatherInitial extends WeatherState {}
class WeatherLoading extends WeatherState {}
class WeatherLoaded extends WeatherState {
  final WeatherEntity weather;
  WeatherLoaded(this.weather);
}
class WeatherError extends WeatherState {
  final String message;
  WeatherError(this.message);
}

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetWeatherUseCase getWeather;

  WeatherBloc(this.getWeather) : super(WeatherInitial()) {
    on<FetchWeather>((event, emit) async {
      emit(WeatherLoading());
      try {
        final weather = await getWeather(event.city);
        emit(WeatherLoaded(weather));
      } catch (e) {
        emit(WeatherError('Ошибка: $e'));
      }
    });
  }
}