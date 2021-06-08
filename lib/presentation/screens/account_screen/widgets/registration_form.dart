import 'package:flutter/material.dart';
import 'package:trawus/presentation/screens/account_screen/components/create_user_in_firestore.dart';
import 'package:trawus/presentation/screens/create_profile/new_profile_screen.dart';
import '../../../../domain/Firebase/auth/user_authentications.dart';
import 'package:trawus/presentation/screens/account_screen/components/email_text_form_field.dart';
import 'package:trawus/presentation/screens/account_screen/components/password_text_form_field.dart';
import 'package:trawus/presentation/screens/account_screen/components/submit_form_button.dart';
import 'package:trawus/presentation/screens/account_screen/components/toggle_signin_and_register_form_button.dart';

class RegistrationForm extends StatefulWidget {
  final Function(bool isSignIn) changeSignInState;

  const RegistrationForm(this.changeSignInState);

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
          emailTextFormField(onSaved: (value) {
            email = value;
          }),
          SizedBox(
            height: 20,
          ),
          passwordTextFormField(
            onChanged: (value) {
              password = value;
            },
            onSaved: (value) {
              password = value;
            },
          ),
          SizedBox(
            height: 20,
          ),
          confirmPasswordTextFormField(
            validator: (value) {
              if (value != password) {
                return "Passwords do not match. Please try Again!";
              }
              return null;
            },
            onSaved: (value) {
              password = value;
            },
          ),
          SizedBox(
            height: 25,
          ),
          submitFormButton(
            isLoading: _isLoading,
            onPressed: _isLoading ? null : _submitForm,
          ),
          SizedBox(
            height: 20,
          ),
          clickHereToSignIn(onTap: _renderSignInForm),
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
      await UserAuth.authenticate(
          email: email, password: password, context: context);
      if (UserAuth.user == null) {
        _changeIsLoadingStatus();
        return;
      }
      String userID = UserAuth.userId;
      if (userID != null) {
        createUserInFireStore(email);
        _formKey.currentState.reset();
        Navigator.of(context)
            .pushReplacementNamed(NewProfileScreen.routeName, arguments: false);
      }
    }
  }

  void _changeIsLoadingStatus() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  void _renderSignInForm() {
    widget.changeSignInState(true);
  }
}
