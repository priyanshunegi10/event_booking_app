import 'package:event_booking_app/components/show_snakbar/show_snak_bar.dart';
import 'package:event_booking_app/pages/home/home_page.dart';
import 'package:event_booking_app/services/data_base/data_base.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignUp {
  final FirebaseAuth auth = FirebaseAuth.instance;

  User? getCurrentUser() {
    return auth.currentUser;
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleuser = await googleSignIn.signIn();

      if (googleuser == null) {
        return;
      }

      final GoogleSignInAuthentication googleAuthentication =
          await googleuser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuthentication.accessToken,
        idToken: googleAuthentication.idToken,
      );

      UserCredential result = await auth.signInWithCredential(credential);

      User? userDetails = result.user;

      if (userDetails != null) {
        if (result.additionalUserInfo!.isNewUser) {
          Map<String, dynamic> userData = {
            'User name': userDetails.displayName,
            'Email': userDetails.email,
            'image': userDetails.photoURL,
            'Id': userDetails.uid,
          };

          await DataBaseMethods().addUserDetails(userData, userDetails.uid);
          if (context.mounted) {
            showSnakBar(context, "Registered Successfully! Welcome.");
          }
        } else {
          if (context.mounted) {
            showSnakBar(context, "Login successful! welcome back");
          }
        }

        if (context.mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        }
      }
    } on FirebaseException catch (e) {
      showSnakBar(context, e.message!);
    }
  }
}
