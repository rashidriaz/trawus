import 'package:flutter/material.dart';
import 'package:trawus/domain/Firebase/firestore/firestore.dart';
import 'package:trawus/presentation/screens/account_screen/components/create_user_in_firestore.dart';
import 'package:trawus/presentation/screens/create_profile/new_profile_screen.dart';
import 'package:trawus/presentation/screens/home_screen/home_screen.dart';
import '../../../../domain/Firebase/auth/user_authentications.dart';
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
        ? LinearProgressIndicator()
        : ImageButton(
            onPressed: signInWithGoogle,
            caption: "Sign in with Google",
            imageUrl: googleLogo,
          );
  }

  Future<void> signInWithGoogle() async {
    _changeIsLoadingState();
    await UserAuth.signInWithGoogle();
    if (UserAuth.userId != null) {
      final userAlreadyExists = await FireStore.userExists(UserAuth.userId);
      _changeIsLoadingState();
      if (!userAlreadyExists) {
        createUserInFireStore(UserAuth.user.email);
        Navigator.of(context)
            .pushReplacementNamed(NewProfileScreen.routeName, arguments: true);
      return;
      }
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName, arguments: false);
    }
  }

  void _changeIsLoadingState() {
    setState(() {
      this._isLoading = !_isLoading;
    });
  }
}
