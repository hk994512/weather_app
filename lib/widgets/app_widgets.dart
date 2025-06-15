import 'package:flutter/material.dart';
import 'package:weather_app/extension/app_extension.dart';

import '../models/data/weather_data.dart';

class AppWidgets {
  Widget buildSearchBar(
    TextEditingController cityController,
    void Function() onPressed,
  ) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: cityController,
            decoration: InputDecoration(
              labelText: 'Enter city name',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              suffixIcon: IconButton(
                icon: const Icon(Icons.search),
                onPressed: onPressed,
              ),
            ),
            onSubmitted: (_) => onPressed,
          ),
        ),
      ],
    );
  }

  Widget buildWeatherCard(BuildContext context, WeatherData weatherData) {
    final weather = weatherData;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final localTime = DateTime.fromMillisecondsSinceEpoch(
      weather.dateTime * 1000,
    );
    final sunrise = DateTime.fromMillisecondsSinceEpoch(weather.sunrise * 1000);
    final sunset = DateTime.fromMillisecondsSinceEpoch(weather.sunset * 1000);

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              '${weather.cityName}, ${weather.country}',
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Local Time: ${localTime.hour}:${localTime.minute.toString().padLeft(2, '0')}',
              style: theme.textTheme.bodyMedium,
            ),
            8.ht,
            Text(
              '${weather.temperature.toStringAsFixed(1)}°C',
              style: theme.textTheme.displayMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.lightBlueAccent : Colors.blue,
              ),
            ),
            Text(
              '${weather.weatherMain} (${weather.weatherDescription})',
              style: theme.textTheme.titleMedium,
            ),
            8.ht,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  'https://openweathermap.org/img/wn/${weather.weatherIcon}@4x.png',
                  width: 100,
                  height: 100,
                ),
                Column(
                  children: [
                    Text(
                      'H: ${weather.tempMax.toStringAsFixed(1)}°C',
                      style: theme.textTheme.titleMedium,
                    ),
                    Text(
                      'L: ${weather.tempMin.toStringAsFixed(1)}°C',
                      style: theme.textTheme.titleMedium,
                    ),
                  ],
                ),
              ],
            ),
            16.ht,
            _buildWeatherDetails(theme, weatherData),
            const SizedBox(height: 16),
            _buildSunriseSunset(sunrise, sunset, theme),
            if (weather.rainLastHour != null) ...[
              8.ht,
              Text(
                'Rain (last hour): ${weather.rainLastHour} mm',
                style: theme.textTheme.bodyLarge,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildWeatherDetails(ThemeData theme, WeatherData weatherData) {
    final weather = weatherData;

    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 3,
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      children: [
        _buildDetailItem(
          icon: Icons.thermostat,
          label: 'Feels like',
          value: '${weather.feelsLike.toStringAsFixed(1)}°C',
          theme: theme,
        ),
        _buildDetailItem(
          icon: Icons.water_drop,
          label: 'Humidity',
          value: '${weather.humidity}%',
          theme: theme,
        ),
        _buildDetailItem(
          icon: Icons.air,
          label: 'Wind',
          value:
              '${weather.windSpeed} m/s (${_getWindDirection(weather.windDeg)})',
          theme: theme,
        ),
        _buildDetailItem(
          icon: Icons.speed,
          label: 'Pressure',
          value: '${weather.pressure} hPa',
          theme: theme,
        ),
        _buildDetailItem(
          icon: Icons.visibility,
          label: 'Visibility',
          value: '${(weather.visibility / 1000).toStringAsFixed(1)} km',
          theme: theme,
        ),
        _buildDetailItem(
          icon: Icons.cloud,
          label: 'Cloudiness',
          value: '${weather.cloudiness}%',
          theme: theme,
        ),
        if (weather.windGust != null)
          _buildDetailItem(
            icon: Icons.air,
            label: 'Wind Gust',
            value: '${weather.windGust} m/s',
            theme: theme,
          ),
      ],
    );
  }

  Widget _buildSunriseSunset(
    DateTime sunrise,
    DateTime sunset,
    ThemeData theme,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            const Icon(Icons.wb_sunny, color: Colors.orange),
            4.ht,
            Text('Sunrise', style: theme.textTheme.bodyMedium),
            Text(
              '${sunrise.hour}:${sunrise.minute.toString().padLeft(2, '0')}',
              style: theme.textTheme.bodyLarge,
            ),
          ],
        ),
        Column(
          children: [
            const Icon(Icons.nightlight, color: Colors.deepPurple),
            4.ht,
            Text('Sunset', style: theme.textTheme.bodyMedium),
            Text(
              '${sunset.hour}:${sunset.minute.toString().padLeft(2, '0')}',
              style: theme.textTheme.bodyLarge,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDetailItem({
    required IconData icon,
    required String label,
    required String value,
    required ThemeData theme,
  }) {
    return Row(
      children: [
        Icon(icon, size: 20),
        8.wt,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: theme.textTheme.bodySmall),
            Text(value, style: theme.textTheme.bodyLarge),
          ],
        ),
      ],
    );
  }

  String _getWindDirection(int degrees) {
    if (degrees >= 337.5 || degrees < 22.5) return 'N';
    if (degrees >= 22.5 && degrees < 67.5) return 'NE';
    if (degrees >= 67.5 && degrees < 112.5) return 'E';
    if (degrees >= 112.5 && degrees < 157.5) return 'SE';
    if (degrees >= 157.5 && degrees < 202.5) return 'S';
    if (degrees >= 202.5 && degrees < 247.5) return 'SW';
    if (degrees >= 247.5 && degrees < 292.5) return 'W';
    return 'NW';
  }
}
