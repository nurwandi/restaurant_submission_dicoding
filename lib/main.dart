import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_2_api/home.dart';
import 'bloc/implement_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          textTheme: const TextTheme(bodyText2: TextStyle(color: Colors.white)),
          colorScheme: ColorScheme.fromSwatch().copyWith(
              primary: const Color(0xFF0777a7),
              secondary: const Color(0xFF94d4ef)),
          backgroundColor: Colors.white),
      home: BlocProvider(
        create: (_) => ImplementBloc()
          ..add(GetAllRestaurant())
          ..add(CheckConection()),
        child: const HomePage(),
      ),
    );
  }
}
