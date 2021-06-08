import 'package:flutter/cupertino.dart';

import 'enums/categories.dart';

class Category {
  Categories category;
  String title;
  String iconUrl;
  String details;

  Category(
      {@required this.category,
      @required this.title,
      @required this.iconUrl,
      @required this.details});
}
