

import 'package:flutter/material.dart';

import '../../../../validations.dart';

TextFormField emailTextFormField({Function onSaved}){
  return           TextFormField(
    textCapitalization: TextCapitalization.none,
    autocorrect: false,
    key: ValueKey("Email"),
    validator: (value) {
      if (value.isEmpty || !Validations.isEmail(value)) {
        return "Invalid Email Address!! Please try Again";
      }
      return null;
    },
    keyboardType: TextInputType.emailAddress,
    decoration: InputDecoration(labelText: "Email Address"),
    onSaved: onSaved,
  );
}