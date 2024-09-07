import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wether_app/domain/model/weather_model.dart';
import 'weather_event.dart';
import 'weather_state.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:location/location.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitial()) {
    on<FetchWeather>(_onFetchWeather);
    on<FetchWeatherByLocation>(_onFetchWeatherByLocation);  // Handle location event
  }

  Future<void> _onFetchWeather(FetchWeather event, Emitter<WeatherState> emit) async {
    emit(WeatherLoading());
    try {
      final weather = await _getWeather(event.city);
      emit(WeatherLoaded(weather));
    } catch (e) {
      emit(WeatherError('Failed to fetch weather data'));
    }
  }

  Future<void> _onFetchWeatherByLocation(FetchWeatherByLocation event, Emitter<WeatherState> emit) async {
    emit(WeatherLoading());
    try {
      final weather = await getWeatherByLocation();
      emit(WeatherLoaded(weather));
    } catch (e) {
      emit(WeatherError('Could not fetch weather for your location'));
    }
  }

  Future<WeatherModel> _getWeather(String city) async {
    final result = await http.get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=$city&APPID=43ea6baaad7663dc17637e22ee6f78f2"));

    if (result.statusCode != 200) throw Exception("Failed to fetch weather data");

    return WeatherModel.fromJson(jsonDecode(result.body));
  }

  Future<WeatherModel> getWeatherByLocation() async {
    Location location = Location();

    try {
      var userLocation = await location.getLocation();
      return _fetchWeatherByCoordinates(userLocation.latitude!, userLocation.longitude!);
    } catch (e) {
      throw Exception('Could not get location');
    }
  }

  Future<WeatherModel> _fetchWeatherByCoordinates(double lat, double lon) async {
    final response = await http.get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&APPID=43ea6baaad7663dc17637e22ee6f78f2"));

    if (response.statusCode != 200) throw Exception("Failed to load weather");

    return jsonParsed(response.body);
  }

  WeatherModel jsonParsed(final response) {
    final decoded = json.decode(response);
    return WeatherModel.fromJson(decoded);
  }
}
