import 'package:geocode/geocode.dart';
import 'package:trawus/Models/location_address.dart';

class FireStoreUserData {
  String gender;
  LocationAddress address;

  FireStoreUserData(this.gender, this.address);

  static FireStoreUserData fromJson(Map<String, dynamic> data) {
    Coordinates coordinates =
        Coordinates(longitude: data['longitude'], latitude: data['latitude']);
    LocationAddress address = LocationAddress(
        coordinates: coordinates,
        streetAddress: data['streetAddress'],
        city: data['city']);
    return FireStoreUserData(data['gender'], address);
  }
}
