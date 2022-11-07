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

//This event will be triggered when you want to store data on your
//sharePref Database
class AddOrRemoveFavouriteRestaurant extends ImplementEvent {
  final String id;

  AddOrRemoveFavouriteRestaurant(this.id);
}

//This event will be triggered when you want to retrive data from your
//sharePref Database
class GerFavouriteRestaurants extends ImplementEvent {}

//This event is for store setting about send or not a notification to the user.

class StoreNotificationSetting extends ImplementEvent {
  final bool state;

  StoreNotificationSetting(this.state);
}

class GetNotificationSettings extends ImplementEvent {}
