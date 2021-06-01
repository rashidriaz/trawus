import 'package:flutter/material.dart';
import 'package:trawus/presentation/screens/account_screen/components/create_user_in_firestore.dart';
import '../../../../domain/Firebase/auth/user_authentications.dart';
import 'package:trawus/presentation/screens/home_screen/home_screen.dart';
import 'package:trawus/presentation/widget/image_button.dart';
import 'package:trawus/constants.dart';

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
            imageUrl: googleLogo,
          );
  }

  Future<void> signInWithGoogle() async {
    _changeIsLoadingState();
    await UserAuth.signInWithGoogle();
    _changeIsLoadingState();
    if (UserAuth.user.uid != null) {
      createUserInFireStore(UserAuth.user.email);
      Navigator.of(context).popAndPushNamed(HomeScreen.routeName);
    }
  }

  void _changeIsLoadingState() {
    setState(() {
      this._isLoading = !_isLoading;
    });
  }
}
