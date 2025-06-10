import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wapp/presentation/bloc/weather_bloc/weather_event.dart';
import 'package:wapp/presentation/bloc/weather_bloc/weather_state.dart';
import '../../../domain/usecases/get_weather_usecase.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetWeatherUseCase getWeather;

  WeatherBloc(this.getWeather) : super(WeatherInitial()) {
    on<FetchWeather>((event, emit) async {
      if (event.city.trim().isEmpty) {
        emit(WeatherError('Пожалуйста, введите название города'));
        return;
      }

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
