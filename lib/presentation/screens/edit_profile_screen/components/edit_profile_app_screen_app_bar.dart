import 'package:flutter/material.dart';
import 'package:trawus/presentation/screens/home_screen/home_screen.dart';

AppBar getEditProfileAppScreenAppBar(BuildContext context) {
  return AppBar(
    title: Text("Edit Profile"),
    leading: IconButton(
      icon: Icon(Icons.arrow_back_ios_rounded),
      color: Colors.white,
      onPressed: () {
        Navigator.pop(context);
      },
    ),
  );
}
