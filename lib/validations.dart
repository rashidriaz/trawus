


class Validations{
  static bool isEmail(String email) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = RegExp(p);

    return regExp.hasMatch(email);
  }

  static String validatePassword(String value) {
    if (value.isEmpty || value.length < 7) {
      return "Password must be at least 7 characters long";
    }
    return null;
  }

  static bool isAValidName(String name){
    RegExp nameRegExp = RegExp('[a-zA-Z]');
    return nameRegExp.hasMatch(name);
  }
}