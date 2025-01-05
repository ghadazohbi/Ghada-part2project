import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class Car {
  final int id;
  final String name;
  final double price;
  final String username;

  Car({ required this.id, required this.name, required this.price, required this.username});

  @override
  String toString() {
    return 'ID: $id\nName: $name\nPrice: \$${price.toStringAsFixed(2)}\nOwner: $username';
  }
}


List<Car> cars = [];


Future<void> fetchCars(double minPrice, double maxPrice, String? category) async {
  String url = 'http://10.0.2.2:8080/getCars.php?minPrice=$minPrice&maxPrice=$maxPrice';

  if (category != null && category.isNotEmpty) {
    url += '&category=$category';
  }

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final List<dynamic> jsonResponse = json.decode(response.body);
    cars = jsonResponse.map((row) {
      return Car(
        id: row['id'],
        name: row['name'],
        price: row['price'].toDouble(),
        username: row['username'],
      );
    }).toList();
  } else {
    throw Exception('Failed to load cars');
  }
}


class ShowCars extends StatelessWidget {
  const ShowCars({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: cars.length,
      itemBuilder: (context, index) {
        return Container(
          color: index % 2 == 0 ? Colors.amber[100] : Colors.cyan[100],
          padding: const EdgeInsets.all(10),
          child: Text(cars[index].toString()),
        );
      },
    );
  }
}