class WeatherData {
  final String cityName;
  final String country;
  final double temperature;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final int humidity;
  final double windSpeed;
  final int windDeg;
  final double? windGust;
  final int pressure;
  final int visibility;
  final int cloudiness;
  final String weatherMain;
  final String weatherDescription;
  final String weatherIcon;
  final int dateTime;
  final int sunrise;
  final int sunset;
  final double? rainLastHour;

  WeatherData({
    required this.cityName,
    required this.country,
    required this.temperature,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.humidity,
    required this.windSpeed,
    required this.windDeg,
    this.windGust,
    required this.pressure,
    required this.visibility,
    required this.cloudiness,
    required this.weatherMain,
    required this.weatherDescription,
    required this.weatherIcon,
    required this.dateTime,
    required this.sunrise,
    required this.sunset,
    this.rainLastHour,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      cityName: json['name'] ?? 'Unknown',
      country: json['sys']['country'] ?? '',
      temperature: json['main']['temp']?.toDouble() ?? 0.0,
      feelsLike: json['main']['feels_like']?.toDouble() ?? 0.0,
      tempMin: json['main']['temp_min']?.toDouble() ?? 0.0,
      tempMax: json['main']['temp_max']?.toDouble() ?? 0.0,
      humidity: json['main']['humidity'] ?? 0,
      windSpeed: json['wind']['speed']?.toDouble() ?? 0.0,
      windDeg: json['wind']['deg'] ?? 0,
      windGust: json['wind']['gust']?.toDouble(),
      pressure: json['main']['pressure'] ?? 0,
      visibility: json['visibility'] ?? 0,
      cloudiness: json['clouds']['all'] ?? 0,
      weatherMain: json['weather'][0]['main'] ?? '',
      weatherDescription: json['weather'][0]['description'] ?? '',
      weatherIcon: json['weather'][0]['icon'] ?? '',
      dateTime: json['dt'] ?? 0,
      sunrise: json['sys']['sunrise'] ?? 0,
      sunset: json['sys']['sunset'] ?? 0,
      rainLastHour: json['rain']?['1h']?.toDouble(),
    );
  }
}
