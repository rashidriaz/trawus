import 'package:flutter/material.dart';
import 'package:trawus/Models/gender.dart';
import 'package:trawus/Models/location_address.dart';
import 'package:trawus/Models/user.dart';
import 'package:trawus/domain/Firebase/auth/user_authentications.dart';
import 'package:trawus/domain/Firebase/firestore/firestore.dart';
import 'package:trawus/domain/helpers/FireStoreUserData.dart';

class UserProvider with ChangeNotifier {
  User _user;

  UserProvider() {
    FireStoreUserData userData;
    FireStore.getUserDataFromFireStore().then((value) {
      if (value != null) userData = FireStoreUserData.fromJson(value);
    });
    _user = User(
      email: UserAuth.user.email,
      name: UserAuth.user.displayName,
      photoUrl: UserAuth.user.photoURL,
    );
    if (userData != null) {
      _user.gender = userData.gender;
      _user.address = userData.address;
    }
    notifyListeners();
  }

  User get user {
    FireStoreUserData userData;
    FireStore.getUserDataFromFireStore().then((value) {
      if (value != null) userData = FireStoreUserData.fromJson(value);
    });
    _user = User(
      email: UserAuth.user.email,
      name: UserAuth.user.displayName,
      photoUrl: UserAuth.user.photoURL,
      gender: userData == null ? Gender.doNotSpecify : userData.gender,
      address:
          userData == null ? LocationAddress.defaultAddress : userData.address,
    );
    notifyListeners();
    return _user;
  }

  void updateUser(User user) {
    this._user = user;
    notifyListeners();
  }

  void createAndUpdateUser(User user) {
    this._user = user;
    FireStore.postUserData(user: _user);
    UserAuth.updateProfile(name: _user.name, photoUrl: _user.photoUrl);
    notifyListeners();
  }
}
