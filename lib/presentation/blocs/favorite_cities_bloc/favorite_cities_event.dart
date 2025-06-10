abstract class FavoriteCitiesEvent {}

class AddCity extends FavoriteCitiesEvent {
  final String cityName;
  AddCity(this.cityName);
}

class RemoveCity extends FavoriteCitiesEvent {
  final String cityName;
  RemoveCity(this.cityName);
}

class SelectCity extends FavoriteCitiesEvent {
  final String cityName;
  SelectCity(this.cityName);
}

class LoadCities extends FavoriteCitiesEvent {}
