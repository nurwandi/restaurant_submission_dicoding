part of 'implement_bloc.dart';

@immutable
abstract class ImplementEvent {}

class GetAllRestaurant extends ImplementEvent {}

class SearchRestaurant extends ImplementEvent {
  final String query;

  SearchRestaurant(this.query);
}

class CheckConection extends ImplementEvent {}

class GetRestaurantDetails extends ImplementEvent {
  final String restaurantId;

  GetRestaurantDetails(this.restaurantId);
}
