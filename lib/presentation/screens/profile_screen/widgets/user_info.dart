import 'package:flutter/material.dart';
import 'package:trawus/Models/user.dart';
import 'package:trawus/components/error_screen.dart';
import 'package:trawus/domain/helpers/user_helper.dart';
import 'package:trawus/presentation/screens/edit_profile_screen/edit_profile_screen.dart';
import 'package:trawus/presentation/screens/profile_screen/components/display_content.dart';

// ignore: must_be_immutable
class UserInformation extends StatelessWidget {
  User user;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: UserHelper().activeUser,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          user = snapshot.data;
          return userInfo(context);
        }
        return errorScreen(context);
      },
    );
  }

  Column userInfo(BuildContext context) {
    return Column(
      children: [
        displayBasicInfo(user),
        const Divider(),
        displayExtraInformation(
            location: user.address.city, rating: "4.5", totalTrips: "100"),
        const Divider(),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            style: ButtonStyle(
              alignment: Alignment.center,
            ),
            onPressed: () {
              Navigator.pop(context);
              Navigator.of(context).pushNamedAndRemoveUntil(
                  EditProfileScreen.routeName, (route) => false,
                  arguments: user);
            },
            child: Text(
              "Edit Profile",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
            ),
          ),
        ),
      ],
    );
  }
}
