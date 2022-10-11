import 'package:flutter/material.dart';
import 'models/restaurant.dart';

class RestaurantDetail extends StatelessWidget {
  const RestaurantDetail({super.key, required this.restaurant});

  final Restaurant restaurant;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
            child: Column(
          children: [
            Hero(
                tag: restaurant.id, child: Image.network(restaurant.pictureId)),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Text(
                    restaurant.name,
                    style: const TextStyle(fontSize: 30, color: Colors.black),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_rounded,
                        color: Colors.red[500],
                        size: 20,
                      ),
                      SizedBox(
                        width: 7,
                      ),
                      Text(
                        restaurant.city,
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.red[500],
                        size: 20,
                      ),
                      SizedBox(
                        width: 7,
                      ),
                      Text(
                        restaurant.rating.toString(),
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                    ],
                  ),
                  SizedBox(height: 25),
                  Text(
                    'Tentang kami',
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                  SizedBox(height: 5),
                  Text(
                    restaurant.description,
                    maxLines: 12,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 13, color: Colors.black),
                  ),
                ],
              ),
            )
          ],
        )),
      ),
    );
  }
}
