import 'dart:convert';

import 'package:restaurant_2_api/models/restaurant.dart';

RestaurantDetails restaurantDetailsFromJson(String str) =>
    RestaurantDetails.fromJson(json.decode(str));

String restaurantDetailsToJson(RestaurantDetails data) =>
    json.encode(data.toJson());

class RestaurantDetails {
  RestaurantDetails({
    required this.error,
    required this.message,
    required this.restaurant,
    required this.customerReviews,
    required this.menus,
  });

  final bool error;
  final String message;
  final Restaurant restaurant;
  final Menus menus;
  final List<CustomerReview> customerReviews;

  factory RestaurantDetails.fromJson(Map<String, dynamic> json) =>
      RestaurantDetails(
        error: json["error"] == null ? null : json["error"],
        message: json["message"] == null ? null : json["message"],
        restaurant: Restaurant.fromJson(json["restaurant"]),
        menus: Menus.fromJson(json["restaurant"]["menus"]),
        customerReviews: (json["restaurant"]["customerReviews"] as List)
            .map((e) => CustomerReview.fromJson(e))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        "error": error == null ? null : error,
        "message": message == null ? null : message,
        "restaurant": restaurant == null ? null : restaurant.toJson(),
        "menus": menus.toJson(),
        "customerReviews": customerReviews,
      };
}

class Category {
  Category({
    required this.name,
  });

  final String name;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
      };
}

class CustomerReview {
  CustomerReview({
    required this.name,
    required this.review,
    required this.date,
  });

  final String name;
  final String review;
  final String date;

  factory CustomerReview.fromJson(Map<String, dynamic> json) => CustomerReview(
        name: json["name"] == null ? null : json["name"],
        review: json["review"] == null ? null : json["review"],
        date: json["date"] == null ? null : json["date"],
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "review": review == null ? null : review,
        "date": date == null ? null : date,
      };
}

class Menus {
  Menus({
    required this.foods,
    required this.drinks,
  });

  final List<Category> foods;
  final List<Category> drinks;

  factory Menus.fromJson(Map<String, dynamic> json) => Menus(
        foods:
            List<Category>.from(json["foods"].map((x) => Category.fromJson(x))),
        drinks: List<Category>.from(
            json["drinks"].map((x) => Category.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "foods": foods == null
            ? null
            : List<dynamic>.from(foods.map((x) => x.toJson())),
        "drinks": drinks == null
            ? null
            : List<dynamic>.from(drinks.map((x) => x.toJson())),
      };
}
