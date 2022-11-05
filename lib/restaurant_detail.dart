import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'bloc/implement_bloc.dart';
import 'models/restaurant.dart';

class RestaurantDetail extends StatelessWidget {
  const RestaurantDetail(
      {super.key, required this.restaurant, required this.shared});
  final SharedPreferences shared;
  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ImplementBloc(shared)..add(GetRestaurantDetails(restaurant.id)),
      child:
          BlocBuilder<ImplementBloc, ImplementState>(builder: (context, state) {
        if (state is RestaurantDetailsState) {
          return Scaffold(
            body: Container(
              color: Colors.white,
              child: SingleChildScrollView(
                  child: Column(
                children: [
                  Hero(
                      tag: restaurant.id,
                      child: Image.network(restaurant.pictureId)),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        Text(
                          restaurant.name,
                          style: const TextStyle(
                              fontSize: 30, color: Colors.black),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on_rounded,
                              color: Colors.red[500],
                              size: 20,
                            ),
                            SizedBox(
                              width: 7,
                            ),
                            Text(
                              restaurant.city,
                              style:
                                  TextStyle(fontSize: 15, color: Colors.black),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.red[500],
                              size: 20,
                            ),
                            SizedBox(
                              width: 7,
                            ),
                            Text(
                              restaurant.rating.toString(),
                              style:
                                  TextStyle(fontSize: 15, color: Colors.black),
                            ),
                          ],
                        ),
                        SizedBox(height: 25),
                        Text(
                          'Tentang kami',
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                        SizedBox(height: 5),
                        Text(
                          restaurant.description,
                          maxLines: 12,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 13, color: Colors.black),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Text(
                          'Minuman',
                          style:
                              TextStyle(fontSize: 18, color: Colors.grey[700]),
                        ),
                        SizedBox(height: 15),
                        SizedBox(
                          height: 100,
                          child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: state.restaurantDetails.menus.drinks
                                  .map((menu) => Card(
                                      child: Container(
                                          width: 120,
                                          height: 120,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            color: Colors.orange.shade400,
                                          ),
                                          child: Center(
                                              child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(menu.name),
                                              SizedBox(
                                                width: 20,
                                              )
                                            ],
                                          )))))
                                  .toList()),
                        ),
                        Text(
                          'Makanan',
                          style:
                              TextStyle(fontSize: 18, color: Colors.grey[700]),
                        ),
                        SizedBox(height: 15),
                        SizedBox(
                          height: 100,
                          child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: state.restaurantDetails.menus.foods
                                  .map((menu) => Card(
                                      child: Container(
                                          width: 120,
                                          height: 120,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            color: Colors.orange.shade400,
                                          ),
                                          child: Center(
                                              child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 12.0),
                                                child: Text(menu.name),
                                              ),
                                            ],
                                          )))))
                                  .toList()),
                        ),
                        const SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  )
                ],
              )),
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      }),
    );
  }
}
