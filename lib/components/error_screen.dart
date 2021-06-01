import 'package:flutter/material.dart';
import 'package:trawus/constants.dart';
import 'package:trawus/presentation/screens/edit_profile_screen/components/edit_profile_app_screen_app_bar.dart';

Scaffold errorScreen(BuildContext context){
  return Scaffold(
    appBar: getEditProfileAppScreenAppBar(context),
    body: Container(
      color: Colors.white,
      child: Center(
        child: Image.asset(errorImage),
      ),
    ),
  );
}