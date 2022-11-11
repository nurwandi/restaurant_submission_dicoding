import 'dart:convert';
import 'restaurant.dart';

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
        error: json["error"],
        message: json["message"],
        restaurant: Restaurant.fromJson(json["restaurant"]),
        menus: Menus.fromJson(json["restaurant"]["menus"]),
        customerReviews: (json["restaurant"]["customerReviews"] as List)
            .map((e) => CustomerReview.fromJson(e))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
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
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
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
        name: json["name"],
        review: json["review"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "review": review,
        "date": date,
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
