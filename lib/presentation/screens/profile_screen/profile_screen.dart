import 'dart:io';

import 'package:flutter/material.dart';
import 'package:trawus/presentation/screens/profile_screen/widgets/user_info.dart';

// ignore: must_be_immutable
class ProfileScreen extends StatelessWidget {
  static const routeName = "/user/ProfileScreen";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Column(
        children: [
          UserInformation(),
          SizedBox(
            height: 20,
          ),
          Divider(
            color: Colors.black26,
            height: 2,
          ),
        ],
      ),
    );
  }

}
