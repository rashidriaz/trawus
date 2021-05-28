import 'package:flutter/material.dart';
import 'package:trawus/Models/gender.dart';
import 'package:trawus/Models/location_address.dart';
import 'package:trawus/Models/user.dart';
import 'package:trawus/domain/Firebase/auth/user_authentications.dart';
import 'package:trawus/domain/Firebase/firestore/firestore.dart';

import 'FireStoreUserData.dart';
Future<void> updateUser(User user, BuildContext context) async {
  try {
    UserAuth.updateProfile(name: user.name, photoUrl: user.photoUrl);
    await FireStore.updateUserData(user: user);
  } catch (error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(error.message),
        backgroundColor: Theme.of(context).errorColor,
      ),
    );
  }
}

User get activeUser {
  FireStoreUserData userData =
  FireStoreUserData.fromJson(FireStore.getUserDataFromFireStore());
  User user = User(
    email: UserAuth.user.email ?? "N/A",
    name: UserAuth.user.displayName ?? "N/A",
    photoUrl: UserAuth.user.photoURL ?? null,
    gender: userData.gender ?? Gender.doNotSpecify,
    address: userData.address ?? LocationAddress.defaultAddress,
  );
  return user;
}

void createAndUpdateUser(User user) {
  FireStore.postUserData(user: user);
  UserAuth.updateProfile(name: user.name, photoUrl: user.photoUrl);
}