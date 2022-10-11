import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

import 'package:restaurant_2_api/api_test.dart';
import 'package:restaurant_2_api/models/restaurant.dart';

import 'package:connectivity_plus/connectivity_plus.dart';

part 'implement_event.dart';
part 'implement_state.dart';

class ImplementBloc extends Bloc<ImplementEvent, ImplementState> {
  final Api api;
  ImplementBloc(this.api) : super(ImplementInitial()) {
    on<GetAllRestaurant>((event, emit) async {
      try {
        var restaurant = await api.list();
        emit(AllRestaurantLoadedState(restaurant.restaurants));
      } catch (_) {
        emit(ErrorState());
      }
    });

    on<CheckConection>((event, emit) async {
      final conectionStream = Connectivity().onConnectivityChanged;

      await emit.onEach(conectionStream, onData: (conectivityResult) {
        if (conectivityResult == ConnectivityResult.wifi ||
            conectivityResult == ConnectivityResult.mobile) {
          emit(HasConnection());
        } else {
          emit(NoConnection());
        }
      });
    });

    on<SearchRestaurant>(
      (event, emit) async {
        try {
          emit(SearchingState());
          if (event.query.isNotEmpty) {
            var restaurant = await api.search(event.query);
            if (restaurant.founded > 0) {
              emit(FoundedRestaurantsState(restaurant.foundedRestaurants));
            } else {
              emit(NoConnection());
            }
          } else {
            emit(NotFoundState());

            var restaurant = await api.list();
            emit(AllRestaurantLoadedState(restaurant.restaurants));
          }

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
        } catch (_) {
          emit(ErrorState());
        }
      },
    );
  }
}
