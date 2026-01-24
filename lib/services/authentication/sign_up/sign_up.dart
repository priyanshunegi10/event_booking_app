import 'package:event_booking_app/components/bottom_vaigation_bar/my_bottom_navigation_bar.dart';
import 'package:event_booking_app/components/show_snakbar/show_snak_bar.dart';
import 'package:event_booking_app/pages/home/home_page.dart';
import 'package:event_booking_app/services/data_base/data_base.dart';
import 'package:event_booking_app/services/shared_pref.dart';
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

      UserCredential result = await FirebaseAuth.instance.signInWithCredential(
        credential,
      );

      User? userDetails = result.user;

      // ✅ SAHI TAREA: Sab kuch 'if' ke andar rakhein
      if (userDetails != null) {
        // 1. Data Phone me Save karein (Shared Prefs)
        await SharedPrefrenceHelper().saveUserId(
          userDetails.uid,
        ); // ✅ Ye sabse important hai
        await SharedPrefrenceHelper().saveUserEmail(userDetails.email ?? "");
        await SharedPrefrenceHelper().saveUserName(
          userDetails.displayName ?? "",
        );
        await SharedPrefrenceHelper().saveUserImage(userDetails.photoURL ?? "");

        // 2. Database ka kaam
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
            showSnakBar(context, "Login successful! Welcome back");
          }
        }

        // 3. Home Page par bhejein
        if (context.mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => MyBottomNvaigationBar()),
          );
        }
      }
    } on FirebaseException catch (e) {
      showSnakBar(context, e.message ?? "An error occurred");
    }
  }
}
