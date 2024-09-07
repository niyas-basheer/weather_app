import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'application/weather_bloc/weather_bloc.dart';
import 'presentation/search_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeatherBloc(),
      child: MaterialApp(
        color: Colors.black,
        debugShowCheckedModeBanner: false,
        home: WeatherSearchPage(),
      ),
    );
  }
}


