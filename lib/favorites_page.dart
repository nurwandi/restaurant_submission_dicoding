import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_2_api/bloc/implement_bloc.dart';
import 'package:restaurant_2_api/widgets/restaurant_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Favorites extends StatelessWidget {
  const Favorites({super.key, required this.shared});
  final SharedPreferences shared;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Favorite Restaurants')),
        body: BlocBuilder<ImplementBloc, ImplementState>(
            buildWhen: (previous, current) =>
                current is FavoriteRestaurantToShow,
            builder: (context, state) {
              if (state is FavoriteRestaurantToShow) {
                return RestaurantCard(
                  shared: shared,
                  restaurants: state.restaurants,
                  favouritesRestaurantsIds: state.favouriteRestaurantsIds,
                );
              } else {
                context.read<ImplementBloc>().add(GerFavouriteRestaurants());
                return const Text('Nothing here...');
              }
            }));
  }
}
