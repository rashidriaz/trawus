import 'package:geocode/geocode.dart';
import 'package:trawus/Models/gender.dart';
import 'package:trawus/Models/location_address.dart';
import 'package:trawus/Models/user.dart';
import 'package:trawus/domain/Firebase/auth/user_authentications.dart';
import 'package:trawus/domain/helpers/geocode_helper.dart';

User get activeUser {
  LocationAddress address;
  Coordinates coordinates;
  getCurrentLocationCoordinates().then(
    (value) => coordinates = value,
  );
  getLocationAddress(coordinates).then((value) => address = value);
  return User(
      email: UserAuth.user.email,
      photoUrl: UserAuth.user.photoURL,
      name: UserAuth.user.displayName,
      gender: Gender.doNotSpecify,
      address: address);
}
