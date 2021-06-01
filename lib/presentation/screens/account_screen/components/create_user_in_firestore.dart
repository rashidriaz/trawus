import 'package:trawus/Models/gender.dart';
import 'package:trawus/Models/location_address.dart';
import 'package:trawus/Models/user.dart';
import 'package:trawus/domain/Firebase/auth/user_authentications.dart';
import 'package:trawus/domain/Firebase/firestore/firestore.dart';

Future<void> createUserInFireStore(String email) async {
  bool userExists = await FireStore.userExists(UserAuth.userId);
  if(userExists){
    return;
  }
  User user = User(
      email: email,
      gender: Gender.doNotSpecify,
      address: LocationAddress.defaultAddress,
      name: email.substring(0, email.indexOf("@")));
  FireStore.postUserData(user: user);
  UserAuth.updateProfile(name: user.name, photoUrl: null);
}
