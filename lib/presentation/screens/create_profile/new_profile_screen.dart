import 'package:flutter/material.dart';
import 'package:trawus/Models/user.dart';
import 'package:trawus/components/error_screen.dart';
import 'package:trawus/domain/helpers/user_helper.dart';
import 'package:trawus/presentation/screens/create_profile/components/waiting_screen.dart';
import 'package:trawus/presentation/screens/create_profile/widgets/create_profile_form.dart';
import 'package:trawus/presentation/screens/create_profile/widgets/phone_number_verification.dart';

// ignore: must_be_immutable
class NewProfileScreen extends StatefulWidget {
  static const routeName = "/User/NewProfileScreen";
  int index = 0;

  @override
  _NewProfileScreenState createState() {
    return _NewProfileScreenState();
  }
}

class _NewProfileScreenState extends State<NewProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final calledAfterSignInWithGoogle =
        ModalRoute.of(context).settings.arguments as bool;
    return widget.index == 0
        ? PhoneNumberVerification(renderNextForm)
        : FutureBuilder(
            future: UserHelper().activeUser,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return waitingScreen();
              }
              if (snapshot.hasData &&
                  snapshot.connectionState == ConnectionState.done) {
                return CreateProfileForm(
                    snapshot.data as User, calledAfterSignInWithGoogle);
              }
              return errorScreen(context);
            },
          );
  }

  void renderNextForm() {
    setState(() {
      widget.index++;
    });
  }
}
