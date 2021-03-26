import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trawus/constants.dart';
import 'package:trawus/domain/Firebase/user_authentications.dart';
import '../../validations.dart';
import 'alert_dialog.dart';

class SignInForm extends StatefulWidget {
  final Function(bool isSignIn) isSignIn;

  const SignInForm(this.isSignIn);

  @override
  _SignInFormState createState() {
    return _SignInFormState();
  }
}

class _SignInFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormState>();
  String email;
  String password;
  bool _isLoading = false;
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            onChanged: (value) {
              if (Validations.isEmail(value)) {
                email = value;
              } else {
                email = null;
              }
            },
            textCapitalization: TextCapitalization.none,
            autocorrect: false,
            validator: (value) {
              if (value.isEmpty || !Validations.isEmail(value)) {
                return "Invalid Email Address! Please try Again";
              }
              return null;
            },
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(labelText: "Email Address"),
            onSaved: (value) {
              email = value;
            },
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            onChanged: (value) {
              return Validations.validatePassword(value);
            },
            validator: (value) {
              return Validations.validatePassword(value);
            },
            decoration: InputDecoration(
              labelText: "Password",
              suffixIcon: IconButton(
                icon: Icon(
                  showPassword ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    showPassword = !showPassword;
                  });
                },
              ),
            ),
            obscureText: showPassword,
            onSaved: (value) {
              password = value;
            },
          ),
          const SizedBox(
            height: 25,
          ),
          TextButton(
              onPressed: forgetPassword, child: Text("Forget Password?")),
          Align(
            child: ElevatedButton(
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
            alignment: Alignment.center,
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              const Text(
                "Don't have an account? Click here to ",
                style: TextStyle(fontSize: 16),
              ),
              InkWell(
                onTap: _renderRegistrationForm,
                child: const Text(
                  "Register",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: primaryColor,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Future<void> _submitForm() async {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState.save();
      changeIsLoadingStatus();
      await UserAuthentication.authenticate(
          email: email, password: password, context: context, signIn: true);
      if (!UserAuthentication.emailVerified()) {
        UserAuthentication.signOut();
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialogBox(
                  title: "Email Unverified!",
                  message:
                      "Verification email sent on $email Verify your email then SignIn",
                  buttonText: "close",
                  onPressed: (){},
                  context: context);
            });
      }
      changeIsLoadingStatus();
    }
  }

  void forgetPassword() {
    if (email == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please enter your email in email field"),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
      return;
    }
    final auth = FirebaseAuth.instance;
    auth.sendPasswordResetEmail(email: email);
    showDialog(
        context: context,
        builder: (context) => AlertDialogBox(
              title: "Reset Your Password",
              context: context,
              message:
                  "An email has been sent on $email Reset your password from there and try again",
              buttonText: "Close",
          onPressed: (){},
            ));
  }

  void changeIsLoadingStatus() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  void _renderRegistrationForm() {
    widget.isSignIn(false);
  }
}
