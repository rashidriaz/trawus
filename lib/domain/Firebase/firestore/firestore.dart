import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trawus/Models/location_address.dart';
import 'package:trawus/Models/user.dart';
import 'package:trawus/domain/Firebase/auth/user_authentications.dart';

class FireStore {
  static Future<void> postUserData({@required User user}) async {
    final fireStoreInstance = FirebaseFirestore.instance;
    final userId = UserAuth.userId;
    await fireStoreInstance.collection('users').doc(userId).set({
      'gender': user.gender,
      'address': LocationAddress.toJSON(user.address),
    });
  }

  static Future<void> updateUserData({@required User user}) async {
    final fireStoreInstance = FirebaseFirestore.instance;
    final userId = UserAuth.userId;
    await fireStoreInstance.collection('users').doc(userId).update({
      'gender': user.gender,
      'address': LocationAddress.toJSON(user.address),
    });
  }

  static Map<String, dynamic> getUserDataFromFireStore() {
    final fireStoreInstance = FirebaseFirestore.instance;
    final id = UserAuth.userId;
    Map<String, dynamic> data;
    final xyz = fireStoreInstance.collection('users').doc(id);
    xyz.get().then((value) {
      data = value.data();
      print(value.toString());
    });
    return data;
  }
}
