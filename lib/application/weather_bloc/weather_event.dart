// weather_event.dart
abstract class WeatherEvent {}

class FetchWeather extends WeatherEvent {
  final String city;
  FetchWeather(this.city);
}

class FetchWeatherByLocation extends WeatherEvent {}  // New event
