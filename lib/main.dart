import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'presentation/blocs/weather_bloc/weather_bloc.dart';
import 'presentation/blocs/favorite_cities_bloc/favorite_cities_bloc.dart';
import 'presentation/pages/weather_page.dart';
import 'data/repositories/weather_repository_impl.dart';
import 'data/datasources/weather_remote_datasource.dart';
import 'domain/usecases/get_weather_usecase.dart';

void main() {
  final repository = WeatherRepositoryImpl(WeatherRemoteDataSource());

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => FavoriteCitiesBloc()),
        BlocProvider(create: (_) => WeatherBloc(GetWeatherUseCase(repository))),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WeatherNow',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const WeatherPage(),
    );
  }
}
