import 'package:event_booking_app/pages/home/widgets/events_cards.dart';
import 'package:event_booking_app/pages/home/widgets/events_types_card.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xffe3e6ff), Color(0xfff1f3ff), Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 10, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.location_on_outlined),
                    Text(
                      "Lodi road new delhi",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 18),
                Text(
                  "Hello, Priyanshu Negi",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Text(
                  "There are 20 events\naround your location.",
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xff6351ec),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  margin: EdgeInsets.only(right: 20),
                  decoration: BoxDecoration(
                    color: Color(0xffffffff),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search a event",
                      suffixIcon: Icon(Icons.search_outlined),
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                    ),
                  ),
                ),

                SizedBox(height: 20),

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      EventsTypesCard(
                        imagePath: "assets/icons/music-note.png",
                        title: "Music",
                      ),

                      EventsTypesCard(
                        imagePath: "assets/icons/t-shirt.png",
                        title: "Clothing",
                      ),
                      EventsTypesCard(
                        imagePath: "assets/icons/party.png",
                        title: "Festival",
                      ),
                      EventsTypesCard(
                        imagePath: "assets/icons/food.png",
                        title: "Food",
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      "Upcoming Events",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "see all",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(width: 20),
                  ],
                ),
                SizedBox(height: 20),
                Column(
                  children: [
                    EventsCards(
                      imagePath: 'assets/images/fashion.jpg',
                      date: 'Dec,\17',
                      title: 'Fashion events',
                      location: 'Mumbai',
                      price: 35,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
