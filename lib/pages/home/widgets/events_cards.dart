import 'package:event_booking_app/pages/events_details/events_detail_page.dart';
import 'package:flutter/material.dart';

class EventsCards extends StatelessWidget {
  final String imagePath;
  final String date;
  final String title;
  final String location;
  final String price;
  const EventsCards({
    super.key,
    required this.imagePath,
    required this.date,
    required this.title,
    required this.location,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(right: 20),
          width: double.infinity,
          child: ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(12),
            child: Stack(
              children: [
                Image.asset(
                  imagePath,
                  height: MediaQuery.of(context).size.height * 0.3 - 60,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  margin: EdgeInsets.only(left: 12, top: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    date,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),

        Row(
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Spacer(),
            Text(
              "$price\$",
              style: TextStyle(
                fontSize: 22,
                color: Color(0xff6351ec),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 20),
          ],
        ),
        SizedBox(height: 5),
        Row(
          children: [
            Icon(Icons.location_on_outlined),
            Text(
              location,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ],
    );
  }
}
