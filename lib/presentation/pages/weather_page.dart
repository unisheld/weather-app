import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wapp/presentation/blocs/weather_bloc/weather_event.dart';
import 'package:wapp/presentation/blocs/weather_bloc/weather_state.dart';
import '../blocs/weather_bloc/weather_bloc.dart';
import '../blocs/favorite_cities_bloc/favorite_cities_bloc.dart';
import '../blocs/favorite_cities_bloc/favorite_cities_event.dart';
import '../blocs/favorite_cities_bloc/favorite_cities_state.dart';
import '../widgets/weather_info_widget.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('WeatherNow')),
      body: Column(
        children: [
          // Список избранных городов
          BlocBuilder<FavoriteCitiesBloc, FavoriteCitiesState>(
            builder: (context, state) {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                child: Row(
                  children: [
                    for (var city in state.cities)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: InputChip(
                          label: Text(city),
                          selected: city == state.selectedCity,
                          onSelected: (_) {
                            context.read<FavoriteCitiesBloc>().add(SelectCity(city));
                            context.read<WeatherBloc>().add(FetchWeather(city));
                          },
                          onDeleted: () {
                            context.read<FavoriteCitiesBloc>().add(RemoveCity(city));
                            if (state.selectedCity == city) {
                              final newSelected = context.read<FavoriteCitiesBloc>().state.selectedCity;
                              if (newSelected != null) {
                                context.read<WeatherBloc>().add(FetchWeather(newSelected));
                              }
                            }
                          },
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: ActionChip(
                        label: const Icon(Icons.add),
                        onPressed: () => _showAddCityDialog(context),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),

          // Погода для выбранного города
          Expanded(
            child: BlocBuilder<WeatherBloc, WeatherState>(
              builder: (context, state) {
                if (state is WeatherInitial) {
                  return const Center(child: Text('Пожалуйста, выберите город'));
                } else if (state is WeatherLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is WeatherLoaded) {
                  final weather = state.weather;

                  final details = [
                    {
                      'label': 'Влажность',
                      'value': '${weather.humidity}%',
                      'icon': Icons.water_drop,
                      'color': Colors.blue,
                    },
                    {
                      'label': 'Ветер',
                      'value': '${weather.windSpeed} м/с',
                      'icon': Icons.air,
                      'color': Colors.green,
                    },
                    {
                      'label': 'Давление',
                      'value': '${weather.pressure} гПа',
                      'icon': Icons.speed,
                      'color': Colors.orange,
                    },
                  ];

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        weather.city,
                        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        weather.description,
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${weather.temperature}°C',
                        style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Row(
                          children: details.map((detail) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4),
                              child: WeatherInfoWidget(
                                label: detail['label'] as String,
                                value: detail['value'] as String,
                                icon: detail['icon'] as IconData,
                                color: detail['color'] as Color,
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  );
                } else if (state is WeatherError) {
                  return Center(child: Text(state.message));
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showAddCityDialog(BuildContext context) {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Добавить город'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: 'Введите название города'),
          autofocus: true,
          onSubmitted: (_) => _submitCity(context, controller),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Отмена'),
          ),
          TextButton(
            onPressed: () => _submitCity(context, controller),
            child: const Text('Добавить'),
          ),
        ],
      ),
    );
  }

  void _submitCity(BuildContext context, TextEditingController controller) {
    final cityName = controller.text.trim();
    if (cityName.isNotEmpty) {
      context.read<FavoriteCitiesBloc>().add(AddCity(cityName));
      context.read<WeatherBloc>().add(FetchWeather(cityName));
      Navigator.pop(context);
    }
  }
}
