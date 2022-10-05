part of 'implement_bloc.dart';

@immutable
abstract class ImplementState {}

class ImplementInitial extends ImplementState {}

class RestaurantLoadedState extends ImplementState {
  final RestaurantList restaurant;

  RestaurantLoadedState(this.restaurant);
}
