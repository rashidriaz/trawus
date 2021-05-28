import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trawus/Models/user.dart';
import 'package:trawus/domain/Firebase/auth/user_authentications.dart';

class FireStore {
  static Future<void> postUserData({@required User user}) async {
    final userId = UserAuth.userId;
    await FirebaseFirestore.instance.collection('users').doc(userId).set({
      'gender': user.gender,
      'city': user.address.city,
      'streetAddress': user.address.streetAddress,
      'latitude': user.address.coordinates.latitude,
      'longitude': user.address.coordinates.longitude,
    });
  }

  static Future<void> updateUserData({@required User user}) async {
    final userId = UserAuth.userId;
    await FirebaseFirestore.instance.collection('users').doc(userId).update({
      'gender': user.gender,
      'city': user.address.city,
      'streetAddress': user.address.streetAddress,
      'latitude': user.address.coordinates.latitude,
      'longitude': user.address.coordinates.longitude,
    });
  }

  static Map<String, dynamic> getUserDataFromFireStore() {
    final id = UserAuth.userId;
    Map<String, dynamic> data;
    final xyz = FirebaseFirestore.instance.collection('users').doc(id);
        xyz.get().then((value) {
      data = value.data();
      print(value.toString());
    });
    return data;
  }
}
