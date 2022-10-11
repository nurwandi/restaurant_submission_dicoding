import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_2_api/widgets/restaurant_card.dart';
import 'bloc/implement_bloc.dart';

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
        body: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: TextField(
                    decoration: const InputDecoration(hintText: "Search"),
                    onChanged: (query) {
                      context
                          .read<ImplementBloc>()
                          .add(SearchRestaurant(query));
                    },
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.8,
                child: BlocBuilder<ImplementBloc, ImplementState>(
                  builder: (context, state) {
                    if (state is HasConnection) {
                      context.read<ImplementBloc>().add(GetAllRestaurant());
                    }
                    if (state is NoConnection) {
                      return const Center(
                          child: Text(
                        'No Internet',
                        style: TextStyle(color: Colors.black),
                      ));
                    }
                    if (state is AllRestaurantLoadedState) {
                      return RestaurantCard(restaurants: state.restaurants);
                    }
                    if (state is FoundedRestaurantsState) {
                      return RestaurantCard(restaurants: state.restaurants);
                    }
                    if (state is SearchingState) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircularProgressIndicator.adaptive(),
                          const Center(
                              child: Text(
                            'Searching.....',
                            style: TextStyle(color: Colors.black),
                          )),
                        ],
                      );
                    }
                    if (state is NotFoundState) {
                      return const Center(
                          child: Text(
                        'Not Found',
                        style: TextStyle(color: Colors.black),
                      ));
                    } else {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircularProgressIndicator.adaptive(),
                          const Center(
                              child: Center(
                                  child: Text('Default Screen.....',
                                      style: TextStyle(color: Colors.black)))),
                        ],
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
