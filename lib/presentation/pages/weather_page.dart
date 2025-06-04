import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/weather_bloc.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Погода')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(labelText: 'Введите город'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                context.read<WeatherBloc>().add(FetchWeather(_controller.text));
              },
              child: const Text('Узнать погоду'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: BlocBuilder<WeatherBloc, WeatherState>(
                builder: (context, state) {
                  if (state is WeatherInitial) {
                    return const Text('Введите город');
                  } else if (state is WeatherLoading) {
                    return const CircularProgressIndicator();
                  } else if (state is WeatherLoaded) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('${state.weather.temperature}°C', style: const TextStyle(fontSize: 32)),
                        Text(state.weather.description),
                        Image.network('https://openweathermap.org/img/wn/${state.weather.icon}@2x.png'),
                      ],
                    );
                  } else if (state is WeatherError) {
                    return Text(state.message);
                  }
                  return const SizedBox.shrink();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}