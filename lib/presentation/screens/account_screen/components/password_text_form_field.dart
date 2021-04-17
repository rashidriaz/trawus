import 'package:flutter/material.dart';

import '../../../../validations.dart';

TextFormField passwordTextFormField({Function onSaved, Function onChanged}) {
  return TextFormField(
    key: ValueKey("password"),
    onChanged: onChanged,
    validator: (value) {
      return Validations.validatePassword(value);
    },
    decoration: InputDecoration(labelText: "Password"),
    obscureText: true,
    onSaved: onSaved,
  );
}

TextFormField confirmPasswordTextFormField(
    {Function onSaved, Function validator}) {
  return TextFormField(
    key: ValueKey("Confirm Password"),
    validator: validator,
    decoration: InputDecoration(labelText: "Confirm Password"),
    obscureText: true,
    onSaved: onSaved
  );
}
