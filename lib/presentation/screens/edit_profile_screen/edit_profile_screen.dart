import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geocode/geocode.dart';
import 'package:provider/provider.dart';
import 'package:trawus/Models/argument_modal_for_edit_profile_screen_argument.dart';
import 'package:trawus/Models/location_address.dart';
import 'package:trawus/Models/user.dart';
import 'package:trawus/components/error_screen.dart';
import 'package:trawus/domain/Firebase/storage/firebase_storage.dart';
import 'package:trawus/domain/helpers/geocode_helper.dart';
import 'package:trawus/domain/helpers/user_helper.dart';
import '../../../domain/Firebase/auth/user_authentications.dart';
import 'package:trawus/presentation/screens/edit_profile_screen/components/edit_profile_app_screen_app_bar.dart';
import 'package:trawus/presentation/screens/edit_profile_screen/widgets/gender_input.dart';
import 'package:trawus/presentation/screens/edit_profile_screen/widgets/location_input.dart';
import 'package:trawus/presentation/screens/edit_profile_screen/widgets/update_button.dart';
import 'package:trawus/presentation/widget/alert_dialog.dart';
import 'components/text_field_validator.dart';
import 'widgets/image_picker.dart';

// ignore: must_be_immutable
class EditProfileScreen extends StatefulWidget {
  static const routeName = "/User/EditUserProfileScreen";
  User user;
  LocationAddress _location;
  String _genderValue;
  bool firstTime = true;

  @override
  _EditProfileScreenState createState() {
    return _EditProfileScreenState();
  }
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  String _name;
  File _image;
  bool _isLoading = false;
  Function updateUserForProfileScreen;

  @override
  Widget build(BuildContext context) {
    if (widget.firstTime) {
      widget.firstTime = false;
      final args = ModalRoute.of(context).settings.arguments
          as ArgumentModalForEditProfileScreen;
      widget.user = args.user;
      updateUserForProfileScreen = args.updateUser;
      widget._location = widget.user.address;
      widget._genderValue = widget.user.gender;
    }
    if (widget.user == null) {
      return errorScreen(context);
    }
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
              const SizedBox(
                height: 20,
              ),
              resetPasswordButton(),
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

    Navigator.of(context).pop();
  }

  Future<void> _updateUser(User _activeUser) async {
    _activeUser.name = _name;
    _activeUser.gender = widget._genderValue;
    _activeUser.address = widget._location;
    if (_image != null) {
      String photoUrl = await FireStorage.updateProfilePicture(_image);
      _activeUser.photoUrl = photoUrl;
    }
    updateUserForProfileScreen(_activeUser);
    context.read<UserHelper>().updateUser(_activeUser, context);
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

  Widget resetPasswordButton() {
    return SizedBox(
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
    );
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
}
