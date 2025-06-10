import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'favorite_cities_event.dart';
import 'favorite_cities_state.dart';

class FavoriteCitiesBloc extends Bloc<FavoriteCitiesEvent, FavoriteCitiesState> {
  static const _citiesKey = 'favorite_cities';

  FavoriteCitiesBloc() : super(FavoriteCitiesState.initial()) {
    on<LoadCities>(_onLoadCities);
    on<AddCity>(_onAddCity);
    on<RemoveCity>(_onRemoveCity);
    on<SelectCity>(_onSelectCity);

    add(LoadCities());
  }

  Future<void> _onLoadCities(LoadCities event, Emitter<FavoriteCitiesState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    final savedCities = prefs.getStringList(_citiesKey) ?? [];
    emit(state.copyWith(cities: savedCities, selectedCity: savedCities.isNotEmpty ? savedCities.first : null));
  }

  Future<void> _onAddCity(AddCity event, Emitter<FavoriteCitiesState> emit) async {
    final updatedCities = List<String>.from(state.cities);
    if (!updatedCities.contains(event.cityName)) {
      updatedCities.add(event.cityName);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList(_citiesKey, updatedCities);
      emit(state.copyWith(cities: updatedCities, selectedCity: event.cityName));
    }
  }

  Future<void> _onRemoveCity(RemoveCity event, Emitter<FavoriteCitiesState> emit) async {
    final updatedCities = List<String>.from(state.cities)..remove(event.cityName);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_citiesKey, updatedCities);

    String? newSelectedCity = state.selectedCity;
    if (state.selectedCity == event.cityName) {
      newSelectedCity = updatedCities.isNotEmpty ? updatedCities.first : null;
    }

    emit(state.copyWith(cities: updatedCities, selectedCity: newSelectedCity));
  }

  void _onSelectCity(SelectCity event, Emitter<FavoriteCitiesState> emit) {
    emit(state.copyWith(selectedCity: event.cityName));
  }
}
