import 'package:flutter/material.dart';
import 'package:restaurant_2_api/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          textTheme: TextTheme(bodyText2: TextStyle(color: Colors.white)),
          colorScheme: ColorScheme.fromSwatch().copyWith(
              primary: Color(0xFF0777a7), secondary: Color(0xFF94d4ef)),
          backgroundColor: Colors.white),
      home: HomePage(),
    );
  }
}
