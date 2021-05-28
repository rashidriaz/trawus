import 'package:geocode/geocode.dart';
import 'package:trawus/Models/location_address.dart';

class FireStoreUserData {
  String gender;
  LocationAddress address;

  FireStoreUserData(this.gender, this.address);

  static FireStoreUserData fromJson(Map<String, dynamic> data) {
    LocationAddress address = LocationAddress.fromJSON(data['address']);
    return FireStoreUserData(data['gender'], address);
  }
}
