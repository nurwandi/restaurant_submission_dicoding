import 'package:meta/meta.dart';
import 'dart:convert';

RestaurantReview restaurantReviewFromJson(String str) =>
    RestaurantReview.fromJson(json.decode(str));

String restaurantReviewToJson(RestaurantReview data) =>
    json.encode(data.toJson());

class RestaurantReview {
  RestaurantReview({
    required this.error,
    required this.message,
    required this.customerReviews,
  });

  final bool error;
  final String message;
  final List<CustomerReview> customerReviews;

  factory RestaurantReview.fromJson(Map<String, dynamic> json) =>
      RestaurantReview(
        error: json["error"] == null ? null : json["error"],
        message: json["message"] == null ? null : json["message"],
        customerReviews: List<CustomerReview>.from(
            json["customerReviews"].map((x) => CustomerReview.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error == null ? null : error,
        "message": message == null ? null : message,
        "customerReviews": customerReviews == null
            ? null
            : List<dynamic>.from(customerReviews.map((x) => x.toJson())),
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
