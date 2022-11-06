import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_2_api/setting_page.dart';
import 'package:restaurant_2_api/widgets/restaurant_card.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'bloc/implement_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.shared}) : super(key: key);
  final SharedPreferences shared;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Allow Notifications'),
            content:
                Text('Our app would like to send you recommended restaurants'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Don\'t allow',
                    style: TextStyle(color: Colors.blue, fontSize: 18),
                  )),
              TextButton(
                  onPressed: () {
                    AwesomeNotifications()
                        .requestPermissionToSendNotifications()
                        .then((_) => Navigator.pop(context));
                  },
                  child: Text(
                    'Allow',
                    style: TextStyle(
                        color: Colors.teal,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ))
            ],
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: SettingPage(
          shared: widget.shared,
        ),
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              SizedBox(width: 10),
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
                  buildWhen: (previous, current) =>
                      current is! FavoriteRestaurantToShow,
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
                      return RestaurantCard(
                          shared: widget.shared,
                          restaurants: state.restaurants,
                          favouritesRestaurantsIds:
                              state.favouriteRestaurantsIds);
                    }
                    if (state is FoundedRestaurantsState) {
                      return RestaurantCard(
                          shared: widget.shared,
                          restaurants: state.restaurants,
                          favouritesRestaurantsIds:
                              state.favouriteRestaurantsIds);
                    }
                    if (state is SearchingState) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          CircularProgressIndicator.adaptive(),
                          Center(
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
                        children: const [
                          CircularProgressIndicator.adaptive(),
                          Center(
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
