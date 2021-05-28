import 'package:flutter/material.dart';
import '../../../../domain/Firebase/auth/user_authentications.dart';
import 'package:trawus/presentation/screens/account_screen/components/email_text_form_field.dart';
import 'package:trawus/presentation/screens/account_screen/components/password_text_form_field.dart';
import 'package:trawus/presentation/screens/account_screen/components/submit_form_button.dart';
import 'package:trawus/presentation/screens/account_screen/components/toggle_signin_and_register_form_button.dart';
import 'package:trawus/presentation/screens/home_screen/home_screen.dart';
import 'package:trawus/presentation/widget/alert_dialog.dart';
import '../../../../validations.dart';

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
          emailTextFormField(
            onSaved: (value) {
              email = value;
            },
          ),
          const SizedBox(
            height: 20,
          ),
          passwordTextFormField(
            onChanged: (value) {
              return Validations.validatePassword(value);
            },
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
            alignment: Alignment.center,
            child: submitFormButton(
              onPressed: _isLoading ? null : _submitForm,
              isLoading: _isLoading,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          clickHereToRegister(onTap: _renderRegistrationForm),
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
      await UserAuth.authenticate(
          email: email, password: password, context: context, signIn: true);
      if (!UserAuth.emailVerified()) {
        UserAuth.signOut();
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialogBox(
                  title: "Email Unverified!",
                  message:
                      "Verification email sent on $email Verify your email then SignIn",
                  buttonText: "close",
                  onPressed: () {},
                  context: context);
            });
      } else {
        Navigator.of(context).popAndPushNamed(HomeScreen.routeName);
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
    UserAuth.resetPassword(email);
    showDialog(
        context: context,
        builder: (context) => AlertDialogBox(
              title: "Reset Your Password",
              context: context,
              message:
                  "An email has been sent on $email Reset your password from there and try again",
              buttonText: "Close",
              onPressed: () {},
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
