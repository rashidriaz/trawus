import 'package:flutter/material.dart';
import 'package:trawus/Models/user.dart';

class ArgumentModalForEditProfileScreen {
  User user;
  Function updateUser;

  ArgumentModalForEditProfileScreen(
      {@required this.user, @required this.updateUser});
}
