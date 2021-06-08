import 'package:flutter/material.dart';
import 'package:trawus/domain/Firebase/auth/user_authentications.dart';
import 'package:trawus/presentation/screens/account_screen/account_screen.dart';

import '../../../../constants.dart';

AppBar homeScreenAppBar({BuildContext context, int index}) {
  return AppBar(
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.white,
      title: Image.asset(
        mainLogo,
        height: 100,
        width: 140,
      ),
      actions: [
        index == 0
            ? TextButton.icon(
                label: Text(
                  "Search",
                  style: TextStyle(color: blackColor),
                ),
                onPressed: () {},
                icon: Icon(
                  Icons.search,
                  color: blackColor,
                ),
              )
            : TextButton.icon(
                label: Text(
                  "LogOut",
                  style: TextStyle(color: blackColor),
                ),
                onPressed:()=> logOut(context),
                icon: Icon(
                  Icons.logout,
                  color: blackColor,
                ),
              ),
      ]);
}

void logOut(BuildContext context) {
  UserAuth.signOut();
  Navigator.of(context).popAndPushNamed(Account.routeName);
}
