import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:trawus/constants.dart';
import 'package:trawus/domain/Firebase/user_authentications.dart';

import '../../validations.dart';
import 'alert_dialog.dart';

class RegistrationForm extends StatefulWidget {
  final Function(bool isSignIn) isSignIn;

  const RegistrationForm(this.isSignIn);

  @override
  _RegistrationFormState createState() {
    return _RegistrationFormState();
  }
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  String email;
  String password;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
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
            onSaved: (value) {
              email = value;
            },
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            key: ValueKey("password"),
            onChanged: (value) {
              password = value;
            },
            validator: (value) {
              return Validations.validatePassword(value);
            },
            decoration: InputDecoration(labelText: "Password"),
            obscureText: true,
            onSaved: (value) {
              password = value;
            },
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            key: ValueKey("Confirm Password"),
            validator: (value) {
              if (value != password) {
                return "Passwords do not match. Please try Again!";
              }
              return null;
            },
            decoration: InputDecoration(labelText: "Confirm Password"),
            obscureText: true,
            onSaved: (value) {
              password = value;
            },
          ),
          SizedBox(
            height: 25,
          ),
          ElevatedButton(
            onPressed: _isLoading ? null : _submitForm,
            child: _isLoading
                ? CircularProgressIndicator()
                : Icon(
                    Icons.keyboard_arrow_right_sharp,
                    size: 40,
                  ),
            style: ElevatedButton.styleFrom(
                shape: CircleBorder(), padding: EdgeInsets.all(18)),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              const Text(
                "Already have an account? Click here to ",
                style: TextStyle(fontSize: 16),
              ),
              InkWell(
                onTap: _renderSignInForm,
                child: const Text(
                  "SignIn",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _submitForm() async {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState.save();
      _changeIsLoadingStatus();
      await UserAuthentication.authenticate(
          email: email, password: password, context: context);
      String userID = UserAuthentication.getUser().uid.toString();
      _changeIsLoadingStatus();
      if (userID != null)
        showDialog(
            context: context,
            builder: (context) => AlertDialogBox(
                  title: "Verify your email",
                  context: context,
                  message:
                      "Verification email sent on $email Verify your email then SignIn",
                  buttonText: "Go to SignIn Screen",
                  onPressed: _renderSignInForm,
                ));
    }
  }

  void _changeIsLoadingStatus() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  void _renderSignInForm() {
    widget.isSignIn(true);
  }
}
