import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trawus/presentation/screens/edit_profile_screen/components/text_field_validator.dart';

TextFormField titleTextFormField(String initialValue, Function onSave) {
  return TextFormField(
    initialValue: initialValue,
    textCapitalization: TextCapitalization.sentences,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    key: ValueKey("Title"),
    keyboardType: TextInputType.name,
    decoration: InputDecoration(
      labelText: "Title",
    ),
    validator: (value) {
      return validateNameTextFormField(value);
    },
    onSaved: onSave,
  );
}

TextFormField descriptionTextFormField(String initialValue, Function onSave) {
  return TextFormField(
    initialValue: initialValue,
    textCapitalization: TextCapitalization.sentences,
    key: ValueKey("Description"),
    keyboardType: TextInputType.multiline,
    minLines: 1,
    maxLines: null,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    decoration: InputDecoration(
      labelText: "Description",
    ),
    validator: (value) {
      return validateDescriptionTextFormField(value);
    },
    onSaved: onSave,
  );
}

TextFormField priceTextFormField(double initialValue, Function onSave) {
  return TextFormField(
    initialValue:
        initialValue.toString() == "null" ? null : initialValue.toString(),
    textCapitalization: TextCapitalization.sentences,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    key: ValueKey("Price"),
    keyboardType: TextInputType.number,
    decoration: InputDecoration(
      labelText: "Price",
    ),
    validator: (value) {
      return validatePriceTextFormField(value);
    },
    onSaved: onSave,
  );
}

Widget elevatedButton({@required Icon icon, @required Function onPressed}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
        primary: Colors.white,
        shape: CircleBorder(),
        padding: EdgeInsets.all(18)),
    child: icon,
    onPressed: onPressed,
  );
}
