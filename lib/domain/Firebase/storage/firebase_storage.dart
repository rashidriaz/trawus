import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:trawus/domain/Firebase/auth/user_authentications.dart';

class FireStorage {
  static Future<String> updateProfilePicture(File image) async {
    final reference = FirebaseStorage.instance
        .ref()
        .child("profile_photos")
        .child(UserAuth.user.uid.toString())
        .child('dp.jpg');
    await reference.putFile(image);
    String url = await reference.getDownloadURL();
    return url;
  }
}
