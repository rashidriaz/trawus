import 'package:flutter/material.dart';

import '../../../../constants.dart';

Row clickHereToRegister({Function onTap}) {
  return Row(
    children: [
      const Text(
        "Don't have an account? Click here to ",
        style: TextStyle(fontSize: 14),
      ),
      InkWell(
        onTap: onTap,
        child: const Text(
          "Register",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            color: primaryColor,
          ),
        ),
      ),
    ],
  );
}

Row clickHereToSignIn({Function onTap}) {
  return Row(
    children: [
      const Text(
        "Already have an account? Click here to ",
        style: TextStyle(fontSize: 14),
      ),
      InkWell(
        onTap: onTap,
        child: const Text(
          "Sign in",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: primaryColor,
          ),
        ),
      ),
    ],
  );
}
