import 'package:event_booking_app/pages/booking/booking_page.dart';
import 'package:event_booking_app/pages/home/home_page.dart';
import 'package:event_booking_app/pages/profile/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class MyBottomNvaigationBar extends StatefulWidget {
  const MyBottomNvaigationBar({super.key});

  @override
  State<MyBottomNvaigationBar> createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNvaigationBar> {
  late List<Widget> pages;
  late HomePage home;
  late BookingPage booking;
  late ProfilePage profile;
  int currentTabindex = 0;

  @override
  void initState() {
    home = HomePage();
    booking = BookingPage();
    profile = ProfilePage();
    pages = [home, booking, profile];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        height: 70,
        color: Colors.black,
        backgroundColor: Colors.white,
        animationDuration: Duration(milliseconds: 500),
        onTap: (int index) {
          setState(() {
            currentTabindex = index;
          });
        },
        items: [
          Icon(Icons.home_outlined, color: Colors.white, size: 35),
          Icon(Icons.book_outlined, color: Colors.white, size: 35),
          Icon(Icons.person_outline, color: Colors.white, size: 35),
        ],
      ),
      body: pages[currentTabindex],
    );
  }
}
