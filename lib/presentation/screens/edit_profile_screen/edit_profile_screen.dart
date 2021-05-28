import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geocode/geocode.dart';
import 'package:provider/provider.dart';
import 'package:trawus/Models/location_address.dart';
import 'package:trawus/Models/user.dart';
import 'package:trawus/domain/Firebase/storage/firebase_storage.dart';
import 'package:trawus/domain/helpers/geocode_helper.dart';
import 'package:trawus/domain/helpers/user_helper.dart';
import '../../../domain/Firebase/auth/user_authentications.dart';
import 'package:trawus/presentation/screens/edit_profile_screen/components/edit_profile_app_screen_app_bar.dart';
import 'package:trawus/presentation/screens/edit_profile_screen/widgets/gender_input.dart';
import 'package:trawus/presentation/screens/edit_profile_screen/widgets/location_input.dart';
import 'package:trawus/presentation/screens/edit_profile_screen/widgets/update_button.dart';
import 'package:trawus/presentation/widget/alert_dialog.dart';
import '../../../validations.dart';
import 'widgets/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  static const routeName = "/User/EditUserProfileScreen";

  @override
  _EditProfileScreenState createState() {
    return _EditProfileScreenState();
  }
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  String _name;
  LocationAddress _location = UserHelper().user.address;
  File _image;
  String _genderValue = UserHelper().user.gender;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    User user = context.watch<UserHelper>().user;
    print(_genderValue);
    return Scaffold(
      appBar: getEditProfileAppScreenAppBar(context),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.05, vertical: 20),
        child: Align(
          alignment: Alignment.center,
          child: Column(
            children: [
              UserImagePicker(setImage, UserAuth.user.photoURL),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      initialValue: user.name,
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
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      enabled: false,
                      initialValue: user.email,
                      textCapitalization: TextCapitalization.none,
                      autofocus: false,
                      key: ValueKey("Email"),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(labelText: "Email"),
                      validator: null,
                      onSaved: null,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InputGender(
                        onChanged: (value) {
                          setState(() {
                            _genderValue = value;
                          });
                        },
                        genderValue: _genderValue),
                    SizedBox(height: 20),
                    InputLocation(_setLocation),
                    SizedBox(height: 20),
                    updateProfileButton(
                        onPressed: () => _onFormSubmitted(user),
                        isLoading: _isLoading),
                    SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  child: Text(
                    "Change Password",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onPressed: !_isLoading ? _resetPassword : null,
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

  String validateNameTextFormField(String value) {
    if (value.isEmpty) {
      return "Name Field Can not be empty";
    }
    if (!Validations.isAValidName(value)) {
      return "Invalid Character entered";
    }
    return null;
  }

  void _resetPassword() {
    UserAuth.resetPassword(UserAuth.user.email);
    showDialog(
        context: context,
        builder: (context) => AlertDialogBox(
              title: "Reset Your Password",
              context: context,
              message:
                  "An email has been sent on ${UserAuth.user.email} Reset your password from there and try again",
              buttonText: "Close",
            ));
  }

  Future<void> _setLocation(Coordinates coordinates) async {
    _location = await getLocationAddress(coordinates);
  }

  void _onFormSubmitted(User user) async {
    _changeIsLoadingState();
    final formIsValid = _formKey.currentState.validate();
    if (!formIsValid) {
      _changeIsLoadingState();
      return;
    }
    _formKey.currentState.save();
    if (_isFormUpdated(user)) {
      _formIsUpdated(user);
    } else {
      _changeIsLoadingState();
    }

    Navigator.of(context).pop();
  }

  void _formIsUpdated(User _activeUser) {
    _activeUser.name = _name;
    _activeUser.gender = _genderValue;
    _activeUser.address = _location;
    if (_image != null) {
      String photoUrl;
      FireStorage.updateProfilePicture(_image).then((value) {
        print(value);
        photoUrl = value;
      });
      _activeUser.photoUrl = photoUrl;
    }
    context.read<UserHelper>().updateUser(_activeUser, context);
    _changeIsLoadingState();
  }

  bool _isFormUpdated(User user) {
    print(user.address);
    if (_name != user?.name ||
        _location.equals(user?.address) ||
        _genderValue != user?.gender ||
        _image != null) {
      return true;
    }
    return false;
  }

  void _changeIsLoadingState() {
    setState(() => _isLoading = !_isLoading);
  }
}
