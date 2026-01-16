import 'package:flutter/material.dart';

class ConcertsImage extends StatelessWidget {
  const ConcertsImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "assets/images/concerts.jpg",
          height: MediaQuery.of(context).size.height * 0.5 - 50,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        SafeArea(
          child: Container(
            margin: EdgeInsets.only(left: 20),
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.arrow_back_outlined),
          ),
        ),
        SafeArea(
          child: Container(
            padding: EdgeInsets.only(bottom: 10),
            margin: EdgeInsets.only(top: 280),
            width: double.infinity,
            decoration: BoxDecoration(color: Colors.black54),
            child: Padding(
              padding: const EdgeInsets.only(top: 6, left: 20, bottom: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Honey singh concert",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.calendar_month, color: Colors.white),
                      SizedBox(width: 5),
                      Text("2026-4-10", style: TextStyle(color: Colors.grey)),
                      SizedBox(width: 20),
                      Icon(Icons.location_on_outlined, color: Colors.white),
                      SizedBox(width: 5),
                      Text("Delhi", style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
