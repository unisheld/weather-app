import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'presentation/bloc/weather_bloc.dart';
import 'presentation/pages/weather_page.dart';
import 'data/repositories/weather_repository_impl.dart';
import 'data/datasources/weather_remote_datasource.dart';
import 'domain/usecases/get_weather_usecase.dart';

void main() {
  final repository = WeatherRepositoryImpl(WeatherRemoteDataSource());
  runApp(MyApp(repository: repository));
}

class MyApp extends StatelessWidget {
  final WeatherRepositoryImpl repository;

  const MyApp({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WeatherNow',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: BlocProvider(
        create: (_) => WeatherBloc(GetWeatherUseCase(repository)),
        child: const WeatherPage(),
      ),
    );
  }
}