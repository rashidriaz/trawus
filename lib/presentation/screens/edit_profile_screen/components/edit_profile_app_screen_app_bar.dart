import 'package:flutter/material.dart';
import 'package:trawus/presentation/screens/home_screen/home_screen.dart';

import '../../../../constants.dart';

AppBar getEditProfileAppScreenAppBar(BuildContext context) {
  return AppBar(
    elevation: 0,
    centerTitle: true,
    backgroundColor: Colors.white,
    title: Text(
      "Edit your Profile",
      style: Theme.of(context).textTheme.headline5,
    ),
    leading: IconButton(
      icon: Icon(Icons.arrow_back_ios_rounded),
      color: primaryColor,
      onPressed: () {
        Navigator.pop(context);
        Navigator.of(context).pushNamedAndRemoveUntil(
            HomeScreen.routeName, (route) => false,
            arguments: true);
      },
    ),
  );
}
