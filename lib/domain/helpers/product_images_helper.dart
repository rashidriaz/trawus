import 'dart:io';

import 'package:trawus/domain/Firebase/storage/firebase_storage.dart';

class ProductImageHelper {
  static Future<List<String>> getLinks(List<File> images) async {
    return await FireStorage.getLinksForImages(images);
  }

  static Map<int, String> toJSON(List<String> urls) {
    Map<int, String> json = {};
    for (int i = 0; i < urls.length; i++) {
      json[i] = urls[i];
    }
    return json;
  }
}
