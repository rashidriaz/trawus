import 'package:flutter/material.dart';
import 'package:trawus/domain/Firebase/user_authentications.dart';
import 'package:trawus/presentation/screens/home_screen/home_screen.dart';
import 'package:trawus/presentation/widget/alert_dialog.dart';
import 'package:trawus/presentation/widget/image_button.dart';

class SignInWithGoogleButton extends StatefulWidget {
  @override
  _SignInWithGoogleButtonState createState() {
    return _SignInWithGoogleButtonState();
  }
}

class _SignInWithGoogleButtonState extends State<SignInWithGoogleButton> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? CircularProgressIndicator()
        : ImageButton(
            onPressed: signInWithGoogle,
            caption: "Sign in with Google",
            imageUrl: "assets/images/google.png",
          );
  }

  Future<void> signInWithGoogle() async {
    _changeIsLoadingState();
    await UserAuthentication.signInWithGoogle();
    _changeIsLoadingState();
    if (UserAuthentication.getUser().uid != null) {
      Navigator.of(context).popAndPushNamed(HomeScreen.routeName);
    }
  }

  void _changeIsLoadingState() {
    setState(() {
      this._isLoading = !_isLoading;
    });
  }
}
