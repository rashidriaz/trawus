import 'package:flutter/material.dart';
import 'package:trawus/domain/helpers/user_helper.dart';

class ProfilePhotoAvatar extends StatelessWidget {
final String imageUrl;
ProfilePhotoAvatar(this.imageUrl);

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
            image: imageUrl == null? AssetImage("assets/images/no_dp.jpg"):
            NetworkImage(imageUrl),
            fit: BoxFit.fill
        ),
      ),
    );
  }
}