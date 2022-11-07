part of 'implement_bloc.dart';

@immutable
abstract class ImplementState {}

class ImplementInitial extends ImplementState {}

class AllRestaurantLoadedState extends ImplementState {
  final List<Restaurant> restaurants;
  final List<String> favouriteRestaurantsIds;

  AllRestaurantLoadedState(this.restaurants, this.favouriteRestaurantsIds);
}

class FoundedRestaurantsState extends ImplementState {
  final List<Restaurant> restaurants;
  final List<String> favouriteRestaurantsIds;
  FoundedRestaurantsState(this.restaurants, this.favouriteRestaurantsIds);
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

class FavoriteRestaurantToShow extends ImplementState {
  final List<Restaurant> restaurants;
  final List<String> favouriteRestaurantsIds;

  FavoriteRestaurantToShow(this.restaurants, this.favouriteRestaurantsIds);
}

class NotificationSettingState extends ImplementState {
  final bool state;

  NotificationSettingState(this.state);
}

class NoFavouritesStored extends ImplementState {}
