import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:trawus/domain/Firebase/auth/user_authentications.dart';

class FireStorage {
  static Future<String> updateProfilePicture(File image) async {
    final reference = FirebaseStorage.instance
        .ref()
        .child("profile_photos")
        .child(UserAuth.userId.toString())
        .child(DateTime.now().toString())
        .child('dp.jpg');
    try {
      await reference.putFile(image);
    } catch (e) {
      print(e.toString());
    }
    String url = await reference.getDownloadURL();
    return url;
  }

  static Future<List<String>> getLinksForImages(List<File> images) async {
    final storage = FirebaseStorage.instance;
    List<String> urls = [];
    int count = 1;
    for (File image in images) {
      String fileName = count.toString() + '.jpg';
      final reference = storage
          .ref()
          .child("ad_photos")
          .child(UserAuth.userId.toString())
          .child(DateTime.now().toString())
          .child(DateTime.now().toString())
          .child(fileName);
      try {
        await reference.putFile(image);
      } catch (e) {
        print(e.toString());
      }
      String url = await reference.getDownloadURL();
      urls.add(url);
      count++;
    }
    return urls;
  }
}
