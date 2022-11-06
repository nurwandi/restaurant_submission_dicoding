import 'dart:convert';

import 'restaurant.dart';

RestaurantList restaurantListFromJson(String str) =>
    RestaurantList.fromJson(json.decode(str));

String restaurantListToJson(RestaurantList data) => json.encode(data.toJson());

class RestaurantList {
  RestaurantList({
    required this.error,
    required this.message,
    required this.count,
    required this.restaurants,
  });

  @override
  String toString() {
    return 'RestaurantList';
  }

  final bool error;
  final String message;
  final int count;
  final List<Restaurant> restaurants;

  factory RestaurantList.fromJson(Map<String, dynamic> json) => RestaurantList(
        error: json["error"],
        message: json["message"],
        count: json["count"],
        restaurants:
            List.from(json["restaurants"].map((x) => Restaurant.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "count": count,
        "restaurants": restaurants == null
            ? null
            : List<dynamic>.from(restaurants.map((x) => x.toJson())),
      };
}
