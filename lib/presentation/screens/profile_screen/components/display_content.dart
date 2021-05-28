
import 'package:flutter/material.dart';
import 'package:trawus/Models/user.dart';
import 'package:trawus/presentation/screens/profile_screen/widgets/profile_picture_avatar.dart';

Container displayCaptionText(String text) {
  return Container(
      child: Text(
    text,
    style: TextStyle(
      fontSize: 16,
      color: Colors.black54,
    ),
  ));
}

Row displayCaptionWithIcon(IconData icon, Color iconColor, String text) {
  return Row(
    children: [
      Icon(
        icon,
        size: 16,
        color: iconColor,
      ),
      displayCaptionText(text),
    ],
  );
}

Container displayContentText(String content) {
  return Container(
      child: Text(
    content,
    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
  ));
}

IntrinsicHeight displayBasicInfo(User user) {
  return IntrinsicHeight(
    child: Row(
      children: [
        ProfilePhotoAvatar(user.photoUrl),
        VerticalDivider(
          color: Colors.black26,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            displayContentText(user.name),
            SizedBox(
              height: 20,
            ),
            displayContentText(user.email),
          ],
        ),
      ],
    ),
  );
}

Row displayExtraInformation(
    {@required String location,
    @required String rating,
    @required String totalTrips}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Column(
        children: [
          displayContentText(location),
          displayCaptionWithIcon(Icons.location_on, Colors.indigo, "Location"),
        ],
      ),
      SizedBox(
        width: 30,
      ),
      Column(
        children: [
          displayContentText(rating),
          displayCaptionWithIcon(
              Icons.star, Colors.orangeAccent, "Avg. Rating"),
        ],
      ),
      SizedBox(
        width: 30,
      ),
      Column(
        children: [
          displayContentText(totalTrips),
          displayCaptionWithIcon(
              Icons.map_outlined, Colors.indigo, "Total Trips"),
        ],
      ),
    ],
  );
}
