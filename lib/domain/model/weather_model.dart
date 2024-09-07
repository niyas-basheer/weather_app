// ignore_for_file: prefer_typing_uninitialized_variables

class WeatherModel {
  final temp;
  final feelsLike;
  final tempMin;
  final tempMax;
  final pressure;
  final humidity;
  final seaLevel;
  final grndLevel;
  final windSpeed;
  final windDeg;
  final windGust;
  final weatherId;
  final weatherMain;
  final weatherDescription;
  final weatherIcon;
  final country;
  final sunrise;
  final sunset;
  final cityName;

  // Temperature conversion from Kelvin to Celsius
  double get getTemp => temp - 273.15;
  double get getMinTemp => tempMin - 273.15;
  double get getMaxTemp => tempMax - 273.15;
  double get feelsLikeTemp => feelsLike - 273.15;

  WeatherModel(
    this.temp,
    this.feelsLike,
    this.tempMin,
    this.tempMax,
    this.pressure,
    this.humidity,
    this.seaLevel,
    this.grndLevel,
    this.windSpeed,
    this.windDeg,
    this.windGust,
    this.weatherId,
    this.weatherMain,
    this.weatherDescription,
    this.weatherIcon,
    this.country,
    this.sunrise,
    this.sunset,
    this.cityName,
  );

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      json['main']['temp'],
      json['main']['feels_like'],
      json['main']['temp_min'],
      json['main']['temp_max'],
      json['main']['pressure'],
      json['main']['humidity'],
      json['main']['sea_level'] ?? 0,
      json['main']['grnd_level'] ?? 0,
      json['wind']['speed'],
      json['wind']['deg'],
      json['wind']['gust'] ?? 0,
      json['weather'][0]['id'],
      json['weather'][0]['main'],
      json['weather'][0]['description'],
      json['weather'][0]['icon'],
      json['sys']['country'],
      json['sys']['sunrise'],
      json['sys']['sunset'],
      json['name'],
    );
  }
}
