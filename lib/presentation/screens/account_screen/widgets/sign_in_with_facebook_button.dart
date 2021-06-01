import 'package:flutter/material.dart';
import 'package:trawus/constants.dart';
import 'package:trawus/presentation/widget/alert_dialog.dart';
import 'package:trawus/presentation/widget/image_button.dart';

class SignInWithFacebookButton extends StatefulWidget {
  @override
  _SignInWithFacebookButtonState createState() {
    return _SignInWithFacebookButtonState();
  }
}

class _SignInWithFacebookButtonState extends State<SignInWithFacebookButton> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? CircularProgressIndicator()
        : ImageButton(
            onPressed: signInWithFacebook,
            caption: "Sign in with Facebook",
            imageUrl: facebookLogo,
          );
  }

  Future<void> signInWithFacebook() async {
    _changeIsLoadingState();
    showDialog(
        context: context,
        builder: (context) => AlertDialogBox(
              title: "Service not available",
              context: context,
              message:
                  "Sorry! This services is not available at the moment. try again later",
              buttonText: "Okay",
              onPressed: () {},
            ));
    _changeIsLoadingState();
  }

  void _changeIsLoadingState() {
    setState(() {
      this._isLoading = !_isLoading;
    });
  }
}
