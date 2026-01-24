import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_booking_app/pages/events_details/events_detail_page.dart';
import 'package:event_booking_app/pages/home/widgets/events_cards.dart';
import 'package:event_booking_app/pages/home/widgets/events_types_card.dart';
import 'package:event_booking_app/services/data_base/data_base.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Stream? eventsStream;

  Future onTheLoad() async {
    eventsStream = await DataBaseMethods().getAllEvents();
    setState(() {});
  }

  @override
  void initState() {
    onTheLoad();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: eventsStream,
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          int eventsCount = snapshot.data.docs.length;
          return Container(
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
                child: SingleChildScrollView(
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
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),

                      Text(
                        "There are $eventsCount events\naround your location.",
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xff6351ec),
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: 20),
                      // ... Search Bar ...
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
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
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
                      ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot ds = snapshot.data.docs[index];

                          String formattedDate = "";
                          try {
                            String inputDate = ds["Date"];
                            DateTime parseDate = DateTime.parse(inputDate);
                            formattedDate = DateFormat(
                              "MMM , dd",
                            ).format(parseDate);
                          } catch (e) {
                            formattedDate = ds["Date"];
                          }

                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EventsDetailPage(
                                    title: ds["Name"],
                                    image: ds["Image"],
                                    location: ds["Location"],
                                    price: ds["price"],
                                    details: ds["events Details"],
                                    date: ds["Date"],
                                  ),
                                ),
                              );
                            },
                            child: EventsCards(
                              imagePath: ds["Image"] == ""
                                  ? 'assets/images/fashion.jpg'
                                  : ds["Image"],
                              date: formattedDate,
                              title: ds["Name"],
                              location: ds["Location"],
                              price: ds["price"],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
