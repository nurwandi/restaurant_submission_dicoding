import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

import 'package:restaurant_2_api/api_test.dart';
import 'package:restaurant_2_api/models/restaurant.dart';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/details.dart';

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
        var restaurant = await api.list();
        emit(AllRestaurantLoadedState(restaurant.restaurants));
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

          emit(SearchingState());
          if (event.query.isNotEmpty) {
            var restaurant = await api.search(event.query);
            if (restaurant.founded > 0) {
              emit(FoundedRestaurantsState(restaurant.foundedRestaurants));
            } else {
              emit(NotFoundState());
            }
          } else {
            var restaurant = await api.list();
            emit(AllRestaurantLoadedState(restaurant.restaurants));
          }
        } on InternetException {
          return emit(NoConnection());
        } catch (_) {
          return emit(ErrorState());
        }
      },
    );
  }
}

class InternetException implements Exception {}
