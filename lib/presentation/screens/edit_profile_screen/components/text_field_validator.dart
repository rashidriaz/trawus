import '../../../../validations.dart';

String validateNameTextFormField(String value) {
  if (value.isEmpty || value == null) {
    return "Name Field Can not be empty";
  }
  if (!Validations.isAValidName(value)) {
    return "Invalid Character entered";
  }
  return null;
}

String validateDescriptionTextFormField(String value) {
  if (value.isEmpty || value == null) {
    return "Description Field Can not be empty";
  }
  return null;
}

String validatePriceTextFormField(String value) {
  if (value.isEmpty || value == null) {
    return "Price is required!";
  }
  if (double.parse(value) < 100) {
    return "price cannot be less than \"100\"";
  }
  return null;
}
