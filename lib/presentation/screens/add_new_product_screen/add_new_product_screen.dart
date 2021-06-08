import 'dart:io';

import 'package:flutter/material.dart';
import 'package:trawus/Models/enums/categories.dart';
import 'package:trawus/presentation/screens/add_new_product_screen/components/add_new_product_screen_app_bar.dart';
import 'package:trawus/presentation/screens/add_new_product_screen/widgets/category_selector_page.dart';
import 'package:trawus/presentation/screens/add_new_product_screen/widgets/new_products_details.dart';
import '../../../constants.dart';

// ignore: must_be_immutable
class AddNewProductScreen extends StatefulWidget {
  static const String routeName = "/addNewProductScreen";
  int index = 0;
  Categories category;
  String title;
  String description;
  double price;
  List<String> headings = [
    "Select Category",
    "Add more details",
    "Select Anything",
  ];

  @override
  _AddNewProductScreenState createState() {
    return _AddNewProductScreenState();
  }
}

class _AddNewProductScreenState extends State<AddNewProductScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          appBar: addNewProductScreenAppBar(
              context, widget.headings[widget.index], _onWillPop),
          body: renderWidget(),
        ),
        onWillPop: _onWillPop);
  }

  // ignore: missing_return
  Widget renderWidget() {
    switch (widget.index) {
      case 0:
        return CategorySelectorPage(
          onTap: onTapForCategoryScreen,
          selectedCategory: widget.category,
        );
      case 1:
        return NewProductDetails(
            title: widget.title,
            description: widget.description,
            price: widget.price,
            onSavedTitle: onSaveForTitle,
            onSavedDescription: onSaveForDescription,
            onSavedPrice: onSaveForPrice,
            onTapForNextButton: onTapForNextButton,
            onTapForPreviousButton: onTapForPreviousButton);
      case 2:
        return Container();
    }
  }

  void onTapForCategoryScreen(Categories category) {
    widget.category = category;
    setState(() {
      widget.index++;
    });
  }

  void onTapForPreviousButton() {
    if (widget.index == 0) return;

    setState(() {
      widget.index--;
    });
  }

  void onTapForNextButton() {
    setState(() {
      widget.index++;
    });
  }

  void onSaveForTitle(String value) {
    widget.title = value;
  }

  void onSaveForDescription(String value) {
    widget.description = value;
  }

  void onSaveForPrice(String value) {
    widget.price = double.parse(value);
  }

  Future<bool> _onWillPop() {
    return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Are you sure?'),
            content: Text('Do you want to discard this product?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('No'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                  exitPage();
                },
                child: Text('Yes'),
              ),
            ],
          ),
        ) ??
        false;
  }

  void exitPage() => Navigator.of(context).pop();
}
