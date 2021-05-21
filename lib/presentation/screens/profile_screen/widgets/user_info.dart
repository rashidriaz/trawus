import 'package:flutter/material.dart';
import 'package:trawus/presentation/screens/edit_profile_screen/edit_profile_screen.dart';
import 'package:trawus/presentation/screens/profile_screen/components/display_content.dart';

class UserInformation extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        displayBasicInfo(),
        Divider(),
        displayExtraInformation(
            location: "LAHORE", rating: "4.5", totalTrips: "100"),
        Divider(),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            style: ButtonStyle(
              alignment: Alignment.center,
            ),
            onPressed: () {
              Navigator.pushNamed(context, EditProfileScreen.routeName);
            },
            child: Text("Edit Profile", style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),),
          ),
        ),
      ],
    );
  }

}