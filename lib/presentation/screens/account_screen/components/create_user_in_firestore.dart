import 'package:trawus/Models/gender.dart';
import 'package:trawus/Models/location_address.dart';
import 'package:trawus/Models/user.dart';
import 'package:trawus/domain/Firebase/auth/user_authentications.dart';
import 'package:trawus/domain/Firebase/firestore/firestore.dart';
import 'package:trawus/domain/helpers/geocode_helper.dart';

Future<void> createUserInFireStore(String email) async {
  bool userExists = await FireStore.userExists(UserAuth.userId);
  if (userExists) {
    return;
  }
  final coordinates = await getCurrentLocationCoordinates();
  final locationAddress = await getLocationAddress(coordinates);
  LocationAddress address = LocationAddress(
      coordinates: coordinates,
      streetAddress: locationAddress.streetAddress,
      city: locationAddress.city);
  User user = User(
      email: email,
      gender: Gender.doNotSpecify,
      address: address,
      name:
          UserAuth.user.displayName ?? email.substring(0, email.indexOf("@")));
  FireStore.postUserData(user: user);
  UserAuth.updateProfile(name: user.name, photoUrl: null);
}
