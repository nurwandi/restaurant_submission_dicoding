import 'package:meta/meta.dart';
import 'dart:convert';

import 'package:restaurant_2_api/models/restaurant.dart';

RestaurantSearch restaurantSearchFromJson(String str) =>
    RestaurantSearch.fromJson(json.decode(str));

String restaurantSearchToJson(RestaurantSearch data) =>
    json.encode(data.toJson());

class RestaurantSearch {
  RestaurantSearch({
    required this.error,
    required this.founded,
    required this.foundedRestaurants,
  });

  final bool error;
  final int founded;
  final List<Restaurant> foundedRestaurants;

  factory RestaurantSearch.fromJson(Map<String, dynamic> json) =>
      RestaurantSearch(
        error: json["error"] == null ? null : json["error"],
        founded: json["founded"] == null ? null : json["founded"],
        foundedRestaurants: List<Restaurant>.from(
            json["restaurants"].map((x) => Restaurant.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error == null ? null : error,
        "founded": founded == null ? null : founded,
        "restaurants": foundedRestaurants == null
            ? null
            : List<dynamic>.from(foundedRestaurants.map((x) => x.toJson())),
      };
}
