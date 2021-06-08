import '../../../../constants.dart';
import 'package:flutter/material.dart';

AppBar addNewProductScreenAppBar(BuildContext context, String title, Function onPressedForBackButton) {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    leading: IconButton(icon: Icon(Icons.arrow_back_ios_sharp, color: primaryColor, size: 30,), onPressed: onPressedForBackButton,),
    centerTitle: true,
    title: Text(title, style: Theme.of(context).textTheme.headline5,)
  );
}