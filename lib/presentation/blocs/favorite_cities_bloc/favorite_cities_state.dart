class FavoriteCitiesState {
  final List<String> cities;
  final String? selectedCity;

  FavoriteCitiesState({required this.cities, this.selectedCity});

  factory FavoriteCitiesState.initial() => FavoriteCitiesState(cities: [], selectedCity: null);

  FavoriteCitiesState copyWith({
    List<String>? cities,
    String? selectedCity,
  }) {
    return FavoriteCitiesState(
      cities: cities ?? this.cities,
      selectedCity: selectedCity ?? this.selectedCity,
    );
  }
}