import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_2_api/widgets/restaurant_card.dart';

import '../bloc/implement_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.restaurant_menu),
              SizedBox(width: 10),
              Text('Restaurants'),
            ],
          ),
        ),
        body: BlocBuilder<ImplementBloc, ImplementState>(
          builder: (context, state) {
            if (state is RestaurantLoadedState) {
              return ListView.builder(
                itemCount: state.restaurant.restaurants.length,
                itemBuilder: (BuildContext context, int index) =>
                    RestaurantCard(
                        restaurant: state.restaurant.restaurants[index]),
              );
            } else {
              return const Center(
                child: Text('You encounter an error!'),
              );
            }
          },
        ));
  }
}
