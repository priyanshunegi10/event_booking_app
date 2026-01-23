import 'package:event_booking_app/components/bottom_vaigation_bar/my_bottom_navigation_bar.dart';
import 'package:event_booking_app/firebase_options.dart';
import 'package:event_booking_app/pages/admin/upload_evenets/upload_events.dart';
import 'package:event_booking_app/pages/sign_up/sign_up_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Booking app",
      theme: ThemeData(
        useMaterial3: true,
        textTheme: GoogleFonts.latoTextTheme(),
      ),

      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshort) {
          if (snapshort.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshort.hasData) {
            return MyBottomNvaigationBar();
          }
          return SignUpPage();
        },
      ),
    );
  }
}