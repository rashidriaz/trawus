import 'package:flutter/material.dart';
import 'package:trawus/presentation/screens/account_screen/widgets/registration_form.dart';
import 'package:trawus/presentation/screens/account_screen/widgets/sign_in_from.dart';

class RenderForm extends StatefulWidget {
  @override
  _RenderFormState createState() {
    return _RenderFormState();
  }
}

class _RenderFormState extends State<RenderForm> {
  bool _isSignIn = true;

  @override
  Widget build(BuildContext context) {
    final displaySize = MediaQuery.of(context).size;
    return Container(
      width: displaySize.width > 700 ? 500 : double.infinity,
      alignment: Alignment.center,
      child: Card(
        elevation: 0,
        margin: EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: _isSignIn
                ? SignInForm(_changeSignInState)
                : RegistrationForm(_changeSignInState),
          ),
        ),
      ),
    );
  }

  void _changeSignInState(bool signIn) {
    setState(() {
      this._isSignIn = signIn;
    });
  }
}
