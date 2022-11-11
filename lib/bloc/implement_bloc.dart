import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../api_test.dart';
import '../models/details.dart';
import '../models/restaurant.dart';
part 'implement_event.dart';
part 'implement_state.dart';

class ImplementBloc extends Bloc<ImplementEvent, ImplementState> {
  final Api api = Api();
  final SharedPreferences sharedPreferences;

  ImplementBloc(this.sharedPreferences) : super(ImplementInitial()) {
    Future<bool> internetConectivity() async {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        return true;
      } else {
        throw InternetException();
      }
    }

    on<GetRestaurantDetails>((event, emit) async {
      final details = await api.details(event.restaurantId);
      emit(RestaurantDetailsState(restaurantDetails: details));
    });

    on<GetAllRestaurant>((event, emit) async {
      try {
        await internetConectivity();
        var listOfFavouritesRestaurants =
            sharedPreferences.getStringList('listOfFavouritesRestaurants') ??
                [];
        var restaurant = await api.list();

        final randomRest = restaurant
            .restaurants[Random().nextInt(restaurant.restaurants.length)];
        sharedPreferences.setString('title', randomRest.name);
        sharedPreferences.setString('body', randomRest.description);
        sharedPreferences.setString('id', randomRest.id);
        emit(AllRestaurantLoadedState(
            restaurant.restaurants, listOfFavouritesRestaurants));
      } on InternetException {
        return emit(NoConnection());
      } catch (_) {
        return emit(ErrorState());
      }
    });

    on<CheckConection>((event, emit) async {
      final conectionStream = Connectivity().onConnectivityChanged;

      await emit.onEach(conectionStream, onData: (conectivityResult) {
        if (conectivityResult == ConnectivityResult.wifi ||
            conectivityResult == ConnectivityResult.mobile) {
          return emit(HasConnection());
        } else {
          return emit(NoConnection());
        }
      });
    });

    on<SearchRestaurant>(
      (event, emit) async {
        try {
          await internetConectivity();
          //Get the restaurants already stored...
          var listOfFavouritesRestaurants =
              sharedPreferences.getStringList('listOfFavouritesRestaurants') ??
                  [];

          emit(SearchingState());
          if (event.query.isNotEmpty) {
            var restaurant = await api.search(event.query);
            if (restaurant.founded > 0) {
              emit(FoundedRestaurantsState(
                  restaurant.foundedRestaurants, listOfFavouritesRestaurants));
            } else {
              emit(NotFoundState());
            }
          } else {
            var restaurant = await api.list();
            emit(AllRestaurantLoadedState(
                restaurant.restaurants, listOfFavouritesRestaurants));
          }
        } on InternetException {
          return emit(NoConnection());
        } catch (_) {
          return emit(ErrorState());
        }
      },
    );
    on<AddOrRemoveFavouriteRestaurant>((event, emit) {
      //Get the restaurants already stored...
      var listOfFavouritesRestaurants =
          sharedPreferences.getStringList('listOfFavouritesRestaurants') ?? [];

      if (listOfFavouritesRestaurants.contains(event.id)) {
        //Remove rest
        listOfFavouritesRestaurants.remove(event.id);
      } else {
        //Add a newone
        listOfFavouritesRestaurants.add(event.id);
      }

      //Store on dataBase
      sharedPreferences.setStringList(
          "listOfFavouritesRestaurants", listOfFavouritesRestaurants);
    });

    on<GerFavouriteRestaurants>((event, emit) async {
      try {
        await internetConectivity();
        var restaurant = await api.list();

        //Get the restaurants already stored...
        var listOfFavouritesRestaurants =
            sharedPreferences.getStringList('listOfFavouritesRestaurants');

        if (listOfFavouritesRestaurants!.length > 0) {
          emit(FavoriteRestaurantToShow(
              getRestaurantFromFavourites(
                  restaurant.restaurants, listOfFavouritesRestaurants),
              listOfFavouritesRestaurants));
        } else {
          emit(NoFavouritesStored());
        }
      } on InternetException {
        return emit(NoConnection());
      } catch (_) {
        return emit(ErrorState());
      }
    });

    on<StoreNotificationSetting>((event, emit) {
      sharedPreferences.setBool("NotificationSetting", !event.state);
      emit(NotificationSettingState(!event.state));
    });

    on<GetNotificationSettings>((event, emit) {
      bool state = sharedPreferences.getBool("NotificationSetting") ?? false;
      emit(NotificationSettingState(state));
    });
  }
}

List<Restaurant> getRestaurantFromFavourites(
    List<Restaurant> restaurants, List<String> ids) {
  var myFilterdList = <Restaurant>[];
  for (var id in ids) {
    myFilterdList
        .add(restaurants.firstWhere((restaurant) => restaurant.id == id));
  }
  return myFilterdList;
}

class InternetException implements Exception {}
