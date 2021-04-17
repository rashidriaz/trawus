import 'package:flutter/material.dart';

Column accountScreenDivider() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Divider(
        color: Colors.grey.shade600,
      ),
      Text(
        "OR ",
        style: TextStyle(
            fontSize: 20,
            color: Colors.grey.shade600,
            fontWeight: FontWeight.w400),
      ),
    ],
  );
}
