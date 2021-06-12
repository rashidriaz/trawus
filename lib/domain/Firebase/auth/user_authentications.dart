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
      return;
    } on FirebaseAuthException catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.message),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
      return;
    } catch (error) {
      String message = "An Error Occurred, please enter valid credentials";
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
      return;
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
    if (authResults.user != null) {
      authResults.user.sendEmailVerification();
    }
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

  static Future<void> updateProfile(
      {@required String name, @required String photoUrl}) async {
    try {
      await FirebaseAuth.instance.currentUser
          .updateDisplayName(name)
          .onError((error, stackTrace) {
        print(error.toString());
        print(stackTrace);
      });
      await FirebaseAuth.instance.currentUser
          .updatePhotoURL(name)
          .onError((error, stackTrace) {
        print(error.toString());
        print(stackTrace);
      });
    } catch (e) {
      print(e);
    }
  }

  static Future<bool> verifyPhoneNumber(Function showSnackBar,
      Function setVerificationID, String phoneNumber) async {
    final _auth = FirebaseAuth.instance;
    //Callback for when the user has already previously signed in with this phone number on this device
    PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential phoneAuthCredential) async {
      await _auth.signInWithCredential(phoneAuthCredential);
      showSnackBar("Phone number automatically verified and user signed in");
    };
    //Listens for errors with verification, such as too many attempts
    PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException authException) {
      showSnackBar(
          'Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}');
      return false;
    };
    //Callback for when the code is sent
    PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      showSnackBar('Please check your phone for the verification code.');
      setVerificationID(verificationId);
    };

    PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      setVerificationID(verificationId);
    };
    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          timeout: const Duration(seconds: 5),
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
      return true;
    } catch (e) {
      showSnackBar("Failed to Verify Phone Number: $e");
      return false;
    }
  }

  static Future<bool> linkPhoneNumberWithUser(
      {@required String verificationId,
      @required String sms,
      Function showSnackBar}) async {
    final _auth = FirebaseAuth.instance;
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: sms,
      );

      await _auth.currentUser.linkWithCredential(credential);

      showSnackBar("Phone Number registered Successfully");
      return true;
    } catch (e) {
      showSnackBar("Failed to register PhoneNumber: " + e.toString());
      return false;
    }
  }
}
