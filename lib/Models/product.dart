import 'package:flutter/material.dart';
import 'package:trawus/Models/location_address.dart';

import 'enums/categories.dart';

class Product {
  String title;
  String description;
  LocationAddress sourceLocation;
  LocationAddress destinationAddress;
  double price;
  Categories category;
  List<String> imagesUrl;

  Product(
      {@required this.title,
      @required this.description,
      @required this.sourceLocation,
      @required this.destinationAddress,
      @required this.price,
      @required this.category,
      @required this.imagesUrl});
}
