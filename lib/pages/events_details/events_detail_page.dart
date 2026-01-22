import 'package:event_booking_app/pages/events_details/widgets/concerts_image.dart';
import 'package:flutter/material.dart';

class EventsDetailPage extends StatelessWidget {
  final String title, image, location, price, details, date;

  const EventsDetailPage({
    super.key,
    required this.title,
    required this.image,
    required this.location,
    required this.price,
    required this.details,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ConcertsImage(
              image: image,
              date: date,
              location: location,
              title: title,
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "About Event",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(details, style: TextStyle(fontSize: 15)),
                  //
                  Row(
                    children: [
                      Text(
                        "Number of Tickets",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 35),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(width: 1.5),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "+",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "1",
                              style: TextStyle(
                                color: Color(0xff6351ec),
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "-",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Container(
                        child: Text(
                          "Amount : \$$price",
                          style: TextStyle(
                            fontSize: 20,
                            color: Color(0xff6351ec),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xff6351ec),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          "Book Now",
                          style: TextStyle(
                            fontSize: 20,
                            color: Color(0xffffffff),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
