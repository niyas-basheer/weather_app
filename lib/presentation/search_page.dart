import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:wether_app/application/weather_bloc/weather_bloc.dart';
import 'package:wether_app/application/weather_bloc/weather_event.dart';
import 'package:wether_app/application/weather_bloc/weather_state.dart';
import 'package:wether_app/presentation/weather_display.dart';

class WeatherSearchPage extends StatelessWidget {
  final TextEditingController _cityController = TextEditingController();

  WeatherSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Weather App')),
      body: BlocListener<WeatherBloc, WeatherState>(
        listener: (context, state) {
          if (state is WeatherError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
          if (state is WeatherLoaded) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ShowWeather(state.weather),
              ),
            );
          }
        },
        child: Column(
          children: [
            const SizedBox(height: 100,),
            Center(
              child: Lottie.asset(
                'assets/Animation - 1725643426136.json',
                width: 200,
                height: 200,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                controller: _cityController,
                decoration: const InputDecoration(
                  labelText: 'Enter city name',
                  border: OutlineInputBorder(),
                ),
                textInputAction: TextInputAction.done,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                final city = _cityController.text.trim();
                if (city.isNotEmpty) {
                  context.read<WeatherBloc>().add(FetchWeather(city));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please enter a city name.')),
                  );
                }
              },
              child: const Text('Get Weather'),
            ),
            TextButton(
              onPressed: () {
                context.read<WeatherBloc>().add(FetchWeatherByLocation());
              },
              child: const Text('Use Current Location'),
            ),
            BlocBuilder<WeatherBloc, WeatherState>(
              builder: (context, state) {
                if (state is WeatherLoading) {
                  return const CircularProgressIndicator();
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
