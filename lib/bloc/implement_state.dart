part of 'implement_bloc.dart';

@immutable
abstract class ImplementState {}

class ImplementInitial extends ImplementState {}

class AllRestaurantLoadedState extends ImplementState {
  final List<Restaurant> restaurants;

  AllRestaurantLoadedState(this.restaurants);
}

class FoundedRestaurantsState extends ImplementState {
  final List<Restaurant> restaurants;

  FoundedRestaurantsState(this.restaurants);
}

class RestaurantDetailsState extends ImplementState {
  final RestaurantDetails restaurantDetails;

  RestaurantDetailsState({required this.restaurantDetails});
}

class SearchingState extends ImplementState {}

class NotFoundState extends ImplementState {}

class ErrorState extends ImplementState {}

class NoConnection extends ImplementState {}

class HasConnection extends ImplementState {}

class FavRestToShow {}
