import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geocode/geocode.dart';
import 'package:trawus/Models/enums/categories.dart';
import 'package:trawus/Models/location_address.dart';
import 'package:trawus/domain/helpers/geocode_helper.dart';
import 'package:trawus/presentation/screens/add_new_product_screen/components/add_new_product_screen_app_bar.dart';
import 'package:trawus/presentation/screens/add_new_product_screen/widgets/add_images.dart';
import 'package:trawus/presentation/screens/add_new_product_screen/widgets/add_locations.dart';
import 'package:trawus/presentation/screens/add_new_product_screen/widgets/category_selector_page.dart';
import 'package:trawus/presentation/screens/add_new_product_screen/widgets/new_products_details.dart';

// ignore: must_be_immutable
class AddNewProductScreen extends StatefulWidget {
  static const String routeName = "/addNewProductScreen";
  List<File> images = [];
  int index = 0;
  Categories category;
  String title;
  String description;
  double price;
  LocationAddress location1 = LocationAddress.defaultAddress;
  LocationAddress location2 = LocationAddress.defaultAddress;

  List<String> headings = [
    "Select Category",
    "Add more details",
    "Add Photos",
    "Select Location(s)",
    "do something",
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
            context: context,
            title: widget.headings[widget.index],
            onPressedForBackButton:
            widget.index == 0 ? _onWillPop : onTapForPreviousButton,
          ),
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
        );
      case 2:
        return AddImagesForNewProduct(
          images: widget.images,
          onPressedForNextButton: onTapForNextButton,
        );
      case 3:
        return SelectLocations(
          onPressedForNextButton: onTapForNextButton,
          location1: widget.location1,
          location2: widget.location2,
          category: widget.category,
          selectLocation1Function: _setLocation1,
          selectLocation2Function: _setLocation2,

        );
      case 4:
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
      builder: (context) =>
          AlertDialog(
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

  Future<void> _setLocation1(Coordinates coordinates) async {
    widget.location1 = await getLocationAddress(coordinates);
  }

  Future<void> _setLocation2(Coordinates coordinates) async {
    widget.location2 = await getLocationAddress(coordinates);
  }

  void exitPage() => Navigator.of(context).pop();

  Future<void> submitForm() async {
    showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(
              title: Text("Post Confirmation"),
              content: Text(
                  "Are you sure you want to post this add on trawus?"),
              actions: [
                TextButton(
                  child: Text("cancel"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text("Post"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ));
  }
}
