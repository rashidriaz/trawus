import 'package:flutter/material.dart';
import 'package:trawus/constants.dart';
Container nothingToShowOnScreen(){
  return Container(
    child: Center(
      child: Image.asset(emptyScreen, height: 250, width: 180,),
    ),
  );
}