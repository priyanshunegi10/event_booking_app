import 'package:event_booking_app/services/authentication/sign_up/sign_up.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      body: Column(
        children: [
          Image.asset("assets/images/onboarding.png"),
          Text(
            "Unlock the Future of",
            style: TextStyle(
              color: Colors.black,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Event Booking App",
            style: TextStyle(
              fontSize: 23,
              color: Color(0xff6351ec),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          Text(
            "Discover, book , and experience\nunforgettable moments effortlessly!",
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),

          SizedBox(height: 25),
          InkWell(
            onTap: () async {
              setState(() {
                isloading = true;
              });

              await SignUp().signInWithGoogle(context);

              setState(() {
                isloading = false;
              });
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                color: Color(0xff6351ec),
                borderRadius: BorderRadius.circular(30),
              ),
              child: isloading
                  ? const Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/icons/google.png", height: 20),
                        SizedBox(width: 20),
                        Text(
                          "Sign in with Google",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
          SizedBox(height: 20),
          Text(
            "Admin panel",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 23,
            ),
          ),
        ],
      ),
    );
  }
}
