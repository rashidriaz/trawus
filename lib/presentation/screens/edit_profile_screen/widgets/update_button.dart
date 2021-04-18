import "package:flutter/material.dart";

ElevatedButton updateProfileButton({Function onPressed, bool isLoading}) {
  return ElevatedButton(
    onPressed: isLoading? null : onPressed,
    child: isLoading
        ? CircularProgressIndicator()
        : Icon(
      Icons.check,
      size: 40,
    ),
    style: ElevatedButton.styleFrom(
        shape: CircleBorder(), padding: EdgeInsets.all(18)),
  );
}