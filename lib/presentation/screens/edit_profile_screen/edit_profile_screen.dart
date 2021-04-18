import 'dart:io';

import 'package:flutter/material.dart';
import 'package:trawus/domain/Firebase/user_authentications.dart';
import 'package:trawus/presentation/screens/edit_profile_screen/components/edit_profile_app_screen_app_bar.dart';
import 'package:trawus/presentation/screens/edit_profile_screen/widgets/update_button.dart';
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
  String _newPassword;
  File _image;
  bool _changePassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getEditProfileAppScreenAppBar(context),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.05, vertical: 20),
        child: Align(
          alignment: Alignment.center,
          child: Column(
            children: [
              UserImagePicker(setImage),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
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
                      height: 40,
                    ),
                    updateProfileButton(onPressed: () {}, isLoading: false),
                    SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.black26,
              ),
              if (_changePassword)
                TextFormField(
                  key: ValueKey("new password"),
                  onChanged: (value) {
                    return Validations.validatePassword(value);
                  },
                  validator: (value) {
                    return Validations.validatePassword(value);
                  },
                  decoration: InputDecoration(labelText: "New Password"),
                  obscureText: true,
                  onSaved: (value) {
                    _newPassword = value;
                  },
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
                  onPressed: () async {
                    if (_changePassword) {
                      await UserAuthentication.updatePassword(_newPassword);
                    }
                    setState(() {
                      _changePassword = (!_changePassword);
                    });
                  },
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

  String validatePasswordTextFormField(String value) {
    if (value.isEmpty || !Validations.isEmail(value)) {
      return "Invalid Email Address!! Please try Again";
    }
    return null;
  }

}
