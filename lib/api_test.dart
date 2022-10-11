import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'models/details.dart';
import 'models/list.dart';
import 'models/review.dart';
import 'models/search.dart';

main() async {
  api
      .review(
    id: 'rqdv5juczeskfw1e867',
    name: 'dart guy',
    message: 'restaurant sucks',
  )
      .then((data) {
    var firstReview = data.customerReviews.first.review;
  });
}

final api = Api();

class Api {
  final _cli = http.Client();
  static const server = 'https://restaurant-api.dicoding.dev';

  Future<RestaurantList> list() async {
    var url = '$server/list';
    var response = await _cli.get(url.uri);
    var json = jsonDecode(response.body);
    return RestaurantList.fromJson(json);
  }

  Future<RestaurantDetails> details(String restaurantId) async {
    var url = '$server/detail/$restaurantId';
    var response = await _cli.get(url.uri);
    var json = jsonDecode(response.body);
    return RestaurantDetails.fromJson(json);
  }

  Future<RestaurantSearch> search(String query) async {
    var url = '$server/search?q=$query';
    var response = await _cli.get(url.uri);
    var json = jsonDecode(response.body);
    return RestaurantSearch.fromJson(json);
  }

  Future<RestaurantReview> review({
    required String id,
    required String name,
    required String message,
  }) async {
    var url = '$server/review';

    var body = jsonEncode({
      'id': id,
      'name': name,
      'review': message,
    });
    var response = await _cli.post(
      url.uri,
      body: body,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );
    var json = jsonDecode(response.body);
    return RestaurantReview.fromJson(json);
  }
}

extension UriExt on String {
  Uri get uri => Uri.parse(this);
}
