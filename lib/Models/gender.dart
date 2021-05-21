
class Gender{
  static const List<String> genders = [
    "male",
    "female",
    "rather not say"
  ];
  static String get doNotSpecify{
    return genders[2];
  }
  static String get male{
    return genders[0];
  }
  static String get female{
    return genders[1];
  }
}