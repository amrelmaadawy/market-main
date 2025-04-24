import 'package:flutter/material.dart';

class Categories {
  final String name;
  final IconData icon;
  Categories({required this.name, required this.icon});
}

List<Categories> categorie = [
  Categories(name: 'Sports', icon: Icons.sports),
  Categories(name: 'Electronics', icon: Icons.tv),
  Categories(name: 'Collections', icon: Icons.collections),
  Categories(name: 'Books', icon: Icons.book),
  Categories(name: 'Games', icon: Icons.games),
  Categories(name: 'Bikes', icon: Icons.bike_scooter),
];
