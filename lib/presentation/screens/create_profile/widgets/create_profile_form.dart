import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocode/geocode.dart';
import 'package:trawus/Models/location_address.dart';
import 'package:trawus/Models/user.dart';
import 'package:trawus/domain/Firebase/auth/user_authentications.dart';
import 'package:trawus/domain/Firebase/storage/firebase_storage.dart';
import 'package:trawus/domain/helpers/geocode_helper.dart';
import 'package:trawus/domain/helpers/user_helper.dart';
import 'package:trawus/presentation/screens/account_screen/account_screen.dart';
import 'package:trawus/presentation/screens/edit_profile_screen/components/text_field_validator.dart';
import 'package:trawus/presentation/screens/edit_profile_screen/widgets/gender_input.dart';
import 'package:trawus/presentation/screens/edit_profile_screen/widgets/image_picker.dart';
import 'package:trawus/presentation/screens/edit_profile_screen/widgets/location_input.dart';
import 'package:trawus/presentation/screens/edit_profile_screen/widgets/update_button.dart';
import 'package:trawus/presentation/screens/home_screen/home_screen.dart';
import 'package:trawus/presentation/widget/alert_dialog.dart';

// ignore: must_be_immutable
class CreateProfileForm extends StatefulWidget {
  User user;
  LocationAddress _location;
  String _genderValue;
  bool calledAfterSignInWithGoogle;

  CreateProfileForm(User user, this.calledAfterSignInWithGoogle) {
    this.user = user;
    _location = user.address;
    _genderValue = user.gender;
  }

  @override
  _CreateProfileFormState createState() {
    return _CreateProfileFormState();
  }
}

class _CreateProfileFormState extends State<CreateProfileForm> {
  final _formKey = GlobalKey<FormState>();
  String _name;
  File _image;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.05, vertical: 20),
        child: Align(
          alignment: Alignment.center,
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              UserImagePicker(setImage, UserAuth.user.photoURL),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    nameTextField(),
                    SizedBox(
                      height: 10,
                    ),
                    emailTextField(),
                    SizedBox(
                      height: 20,
                    ),
                    InputGender(
                        onChanged: (value) {
                          setState(() {
                            widget._genderValue = value;
                          });
                        },
                        genderValue: widget._genderValue),
                    const SizedBox(height: 20),
                    InputLocation(_setLocation, widget.user),
                    const SizedBox(height: 20),
                    updateProfileButton(
                        onPressed: () => _onFormSubmitted(widget.user),
                        isLoading: _isLoading),
                    const SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void setImage(File image) {
    _image = image;
  }

  Future<void> _setLocation(Coordinates coordinates) async {
    widget._location = await getLocationAddress(coordinates);
  }

  Future<void> _onFormSubmitted(User user) async {
    _changeIsLoadingState();
    final formIsValid = _formKey.currentState.validate();
    if (!formIsValid) {
      _changeIsLoadingState();
      return;
    }
    _formKey.currentState.save();
    if (_isFormUpdated(user)) {
      await _updateUser(user);
    }
    _changeIsLoadingState();

    if (widget.calledAfterSignInWithGoogle) {
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName, arguments: false);
      return;
    }
    UserAuth.signOut();
    showDialog(
        context: context,
        builder: (context) => AlertDialogBox(
              title: "Verify your email",
              context: context,
              message:
                  "Verification email sent on ${user.email} Verify your email then SignIn",
              buttonText: "Go to SignIn Screen",
              onPressed: () =>
                  Navigator.of(context).pushReplacementNamed(Account.routeName),
            ));
  }

  Future<void> _updateUser(User _activeUser) async {
    _activeUser.name = _name;
    _activeUser.gender = widget._genderValue;
    _activeUser.address = widget._location;
    if (_image != null) {
      String photoUrl = await FireStorage.updateProfilePicture(_image);
      _activeUser.photoUrl = photoUrl;
    }
    UserHelper().updateUser(_activeUser, context);
    _changeIsLoadingState();
  }

  bool _isFormUpdated(User user) {
    if (_name != user?.name ||
        widget._location.equals(user?.address) ||
        widget._genderValue != user?.gender ||
        _image != null) {
      return true;
    }
    return false;
  }

  void _changeIsLoadingState() {
    setState(() => _isLoading = !_isLoading);
  }

  Widget nameTextField() {
    return TextFormField(
      initialValue: widget.user.name,
      textCapitalization: TextCapitalization.none,
      autofocus: false,
      key: ValueKey("Name"),
      keyboardType: TextInputType.name,
      decoration: InputDecoration(labelText: "Name"),
      validator: (value) {
        return validateNameTextFormField(value);
      },
      onSaved: (value) {
        _name = value;
      },
    );
  }

  Widget emailTextField() {
    return TextFormField(
      enabled: false,
      initialValue: widget.user.email,
      textCapitalization: TextCapitalization.none,
      autofocus: false,
      key: ValueKey("Email"),
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(labelText: "Email"),
      validator: null,
      onSaved: null,
    );
  }
}
