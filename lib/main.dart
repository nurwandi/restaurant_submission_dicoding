import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_2_api/home.dart';

import 'api_test.dart';
import 'bloc/implement_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final Api api = Api();

  // This widget is the root of your application.
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
        create: (_) => ImplementBloc(api)..add(GetAllRestaurant()),
        child: const HomePage(),
      ),
    );
  }
}
