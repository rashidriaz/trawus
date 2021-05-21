import 'package:flutter/material.dart';
import 'package:trawus/Models/gender.dart';

class InputGender extends StatelessWidget {
  Function(String) onChanged;
  String genderValue;

  InputGender({@required this.onChanged, @required this.genderValue});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "Select Gender: ",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w300,
          ),
          textAlign: TextAlign.start,
        ),
        SizedBox(
          width: 25,
        ),
        DropdownButton(
          value: genderValue,
          elevation: 5,
          style: TextStyle(
            fontSize: 18,
            color: Colors.black87,
          ),
          onChanged: onChanged,
          items: Gender.genders.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ],
    );
  }
}
