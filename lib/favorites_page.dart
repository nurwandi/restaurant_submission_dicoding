import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bloc/implement_bloc.dart';
import 'widgets/restaurant_card.dart';

class Favorites extends StatelessWidget {
  const Favorites({super.key, required this.shared});
  final SharedPreferences shared;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Favorite Restaurants')),
        body: BlocBuilder<ImplementBloc, ImplementState>(
            buildWhen: (previous, current) => [
                  FavoriteRestaurantToShow,
                  NoFavouritesStored
                ].contains(current.runtimeType),
            builder: (context, state) {
              if (state is FavoriteRestaurantToShow) {
                return RestaurantCard(
                  shared: shared,
                  restaurants: state.restaurants,
                  favouritesRestaurantsIds: state.favouriteRestaurantsIds,
                );
              } else {
                return const Center(
                    child: Text(
                  'No favorite restaurants to show...',
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ));
              }
            }));
  }
}
