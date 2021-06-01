import '../../../../validations.dart';

String validateNameTextFormField(String value) {
  if (value.isEmpty) {
    return "Name Field Can not be empty";
  }
  if (!Validations.isAValidName(value)) {
    return "Invalid Character entered";
  }
  return null;
}