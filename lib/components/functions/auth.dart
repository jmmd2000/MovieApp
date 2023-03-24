import 'package:api/components/functions/db.dart';
import 'package:api/main.dart';
import 'package:api/pages/discover_page.dart';
import 'package:api/pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

// The signInWithGoogle and signOut functions were adapted from code found in the FlutterFire docs
// https://firebase.flutter.dev/docs/auth/social/

final FirebaseAuth auth = FirebaseAuth.instance;
// This function basically just logs the user in and returns true/false depending on if there is an error.

Future<bool> signInWithGoogle(auth) async {
  try {
    UserCredential userCredential;
    final GoogleSignInAccount googleUser = (await GoogleSignIn().signIn())!;
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final googleAuthCredential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    userCredential = await auth.signInWithCredential(googleAuthCredential);

    return true;
  } catch (e) {
    return false;
  }
}

// This function logs the user out and then checks the login status to return the user to the login page again
Future<void> signOut({required BuildContext context, user, auth}) async {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  try {
    await googleSignIn.disconnect();
    await FirebaseAuth.instance.signOut();
    loginCheck(auth, context);
  } catch (e) {}
}

// This function checks the status of the auth and user objects and either sends the user to the login
// page if they are null or proceed to the homepage
void loginCheck(auth, context) {
  if (auth == null) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  } else if (auth.currentUser != null) {
    storeUser();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const DiscoverPage()),
    );
    appSetup();
  } else {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }
}
