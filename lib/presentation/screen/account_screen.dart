import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:trawus/domain/Firebase/user_authentications.dart';
import 'package:trawus/presentation/widget/alert_dialog.dart';
import 'package:trawus/presentation/widget/image_button.dart';
import 'package:trawus/presentation/widget/main_logo.dart';
import 'package:trawus/presentation/widget/registration_form.dart';
import 'package:trawus/presentation/widget/sign_in_from.dart';

class Account extends StatefulWidget {
  static const routeName = "/accountScreen";
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  bool isSignIn = true;
  bool _isLoadingSignInWithGoogle = false;
  bool _isLoadingSignInWithFacebook = false;

  @override
  Widget build(BuildContext context) {
    final displaySize = MediaQuery.of(context).size;
    double sizedBoxHeight = kIsWeb ? 0 : (displaySize.height * 0.05);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: sizedBoxHeight,
            ),
            const MainLogo(),
            SizedBox(
              height: displaySize.height * 0.02,
            ),
            Container(
                width: displaySize.width > 700 ? 500 : double.infinity,
                alignment: Alignment.center,
                child: Card(
                  elevation: 0,
                  margin: EdgeInsets.all(15),
                  child: SingleChildScrollView(
                      child: Padding(
                    padding: EdgeInsets.all(20),
                    child: isSignIn
                        ? SignInForm(_isSignIn)
                        : RegistrationForm(_isSignIn),
                  )),
                )),
            Container(
              width: displaySize.width > 700 ? 500 : double.infinity,
              alignment: Alignment.center,
              child: Column(
                children: [
                  Divider(
                    color: Colors.grey.shade600,
                  ),
                  Text(
                    "OR ",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w400),
                  ),
                  _isLoadingSignInWithGoogle
                      ? CircularProgressIndicator()
                      : ImageButton(
                          onPressed: signInWithGoogle,
                          caption: "SignIn with Google",
                          imageUrl: "assets/images/google.png",
                        ),
                  _isLoadingSignInWithFacebook
                      ? CircularProgressIndicator()
                      : ImageButton(
                          onPressed: signInWithFacebook,
                          caption: "SignIn with Facebook",
                          imageUrl: "assets/images/facebook.png",
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> signInWithGoogle() async {
    changeIsLoadingStatus(_isLoadingSignInWithGoogle);
    await UserAuthentication.signInWithGoogle();
    changeIsLoadingStatus(_isLoadingSignInWithGoogle);
    if (UserAuthentication.getUser().uid != null) {
      print("User Signed In!");
    }
  }

  Future<void> signInWithFacebook() async {
    changeIsLoadingStatus(_isLoadingSignInWithFacebook);
    showDialog(
        context: context,
        builder: (context) => AlertDialogBox(
              title: "Service not available",
              context: context,
              message:
                  "Sorry! This services is not available at the moment. try again later",
              buttonText: "Okay",
              onPressed: () {},
            ));
    changeIsLoadingStatus(_isLoadingSignInWithFacebook);
  }

  void _isSignIn(bool signIn) {
    setState(() {
      this.isSignIn = signIn;
    });
  }

  void changeIsLoadingStatus(bool loading) {
    setState(() {
      loading = !loading;
    });
  }
}
