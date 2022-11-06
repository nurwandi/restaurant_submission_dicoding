import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_2_api/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'bloc/implement_bloc.dart';

void main() async {
  final pref = await SharedPreferences.getInstance();
  runApp(MyApp(shared: pref));
}

class MyApp extends StatelessWidget {
  final SharedPreferences shared;
  const MyApp({super.key, required this.shared});

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
        create: (_) => ImplementBloc(shared)
          ..add(GetAllRestaurant())
          ..add(CheckConection()),
        child: HomePage(
          shared: shared,
        ),
      ),
    );
  }
}
