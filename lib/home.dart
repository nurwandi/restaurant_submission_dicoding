import 'package:flutter/material.dart';
import 'package:restaurant_2_api/models/details.dart';
import 'package:restaurant_2_api/widgets/restaurant_card.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.restaurant_menu),
              const SizedBox(width: 10),
              const Text('Restaurants'),
            ],
          ),
        ),
        body: RestaurantCard());
  }
}
