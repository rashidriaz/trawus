import 'package:flutter/material.dart';
import 'package:trawus/Models/argument_modal_for_edit_profile_screen_argument.dart';
import 'package:trawus/Models/user.dart';
import 'package:trawus/components/error_screen.dart';
import 'package:trawus/domain/helpers/user_helper.dart';
import 'package:trawus/presentation/screens/edit_profile_screen/edit_profile_screen.dart';
import 'package:trawus/presentation/screens/profile_screen/components/display_content.dart';

// ignore: must_be_immutable
class UserInformation extends StatefulWidget {
  @override
  _UserInformationState createState() {
    return _UserInformationState();
  }
}

class _UserInformationState extends State<UserInformation> {
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
              Navigator.pushNamed(context, EditProfileScreen.routeName,
                  arguments: ArgumentModalForEditProfileScreen(
                      user: user, updateUser: updateUser));
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

  void updateUser(User activeUser) {
    this.user = activeUser;
  }
}
