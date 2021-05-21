import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserAuth {
  static Future<void> authenticate(
      {@required email,
      @required String password,
      @required BuildContext context,
      bool signIn = false}) async {
    try {
      if (signIn) {
        await UserAuth._signIn(
            email: email, password: password, context: context);
      } else {
        await UserAuth._register(
            email: email, password: password, context: context);
      }
    } on PlatformException catch (error) {
      String message = "An Error Occurred, please enter valid credentials";
      _onPlatformException(error: error, context: context, message: message);
    } on FirebaseAuthException catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.message),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
    } catch (error) {
      String message = "An Error Occurred, please enter valid credentials";
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
    }
  }

  static Future<void> _signIn(
      {@required String email,
      @required String password,
      @required BuildContext context}) async {
    final auth = FirebaseAuth.instance;
    await auth.signInWithEmailAndPassword(email: email, password: password);
  }

  static Future<void> _register(
      {@required String email,
      @required String password,
      @required BuildContext context}) async {
    final auth = FirebaseAuth.instance;
    final authResults = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    authResults.user.sendEmailVerification();
  }

  static void _onPlatformException(
      {@required PlatformException error,
      @required BuildContext context,
      @required String message}) {
    if (error.message != null) message = error.message;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(context).errorColor,
      ),
    );
  }

  static bool emailVerified() {
    return FirebaseAuth.instance.currentUser.emailVerified;
  }

  static void signOut() {
    FirebaseAuth.instance.signOut();
  }

  static User get user {
    return FirebaseAuth.instance.currentUser;
  }

  static Future<void> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(credential);
  }

  static void resetPassword(String email) {
    final auth = FirebaseAuth.instance;
    auth.sendPasswordResetEmail(email: email);
  }

  static String get userId {
    return FirebaseAuth.instance.currentUser.uid;
  }

  static bool isLoggedIn() {
    return FirebaseAuth.instance.currentUser != null;
  }

  static void updateProfile(
      {@required String name, @required String photoUrl}) {
    FirebaseAuth.instance.currentUser
        .updateProfile(displayName: name, photoURL: photoUrl);
  }

  static void updateEmail(String email){
    FirebaseAuth.instance.currentUser.verifyBeforeUpdateEmail(email);
  }
}
