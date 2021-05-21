import 'package:flutter/material.dart';

AppBar mapScreenAppBar(
    {@required Function onPressed}) {
  return AppBar(
    title: Text('Choose Location'),
    actions: <Widget>[
        IconButton(
          icon: Icon(Icons.check),
          onPressed: onPressed,
        ),
    ],
  );
}
