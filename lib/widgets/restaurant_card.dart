import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_2_api/bloc/implement_bloc.dart';
import 'package:restaurant_2_api/restaurant_detail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/restaurant.dart';

class RestaurantCard extends StatelessWidget {
  final List<String> favouritesRestaurantsIds;
  final List<Restaurant> restaurants;
  final SharedPreferences shared;
  const RestaurantCard({
    Key? key,
    required this.favouritesRestaurantsIds,
    required this.restaurants,
    required this.shared,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: restaurants.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            behavior: HitTestBehavior.deferToChild,
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => RestaurantDetail(
                            shared: shared,
                            restaurant: restaurants[index],
                          )));
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
              width: MediaQuery.of(context).size.width,
              height: 180,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.6),
                    offset: const Offset(
                      0.0,
                      10.0,
                    ),
                    blurRadius: 10.0,
                    spreadRadius: -6.0,
                  ),
                ],
                image: DecorationImage(
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.35),
                    BlendMode.multiply,
                  ),
                  image: NetworkImage(restaurants[index].pictureId),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Text(
                        restaurants[index].name,
                        style: const TextStyle(
                          fontSize: 19,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(5),
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 18,
                              ),
                              const SizedBox(width: 7),
                              Text(restaurants[index].rating.toString()),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(5),
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.location_city,
                                color: Colors.yellow,
                                size: 18,
                              ),
                              const SizedBox(width: 7),
                              Text(restaurants[index].city),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(5),
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: GestureDetector(
                            onTap: () {
                              context.read<ImplementBloc>().add(
                                  AddOrRemoveFavouriteRestaurant(
                                      restaurants[index].id));

                              context
                                  .read<ImplementBloc>()
                                  .add(GetAllRestaurant());

                              context
                                  .read<ImplementBloc>()
                                  .add(GerFavouriteRestaurants());
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.favorite,
                                  color: (favouritesRestaurantsIds
                                          .contains(restaurants[index].id))
                                      ? Colors.yellow
                                      : Colors.grey,
                                  size: 18,
                                ),
                                const SizedBox(width: 7),
                                const Text('Favorite'),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
