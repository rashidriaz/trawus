import 'package:flutter/material.dart';

class ProfilePhotoAvatar extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.grey,
        shape: BoxShape.circle,
        image: DecorationImage(
            image: AssetImage("assets/images/no_dp.jpg"),
            fit: BoxFit.fill
        ),
      ),
    );
  }
}