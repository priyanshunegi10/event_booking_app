import 'package:flutter/material.dart';

class EventsTypesCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final VoidCallback ontap;
  const EventsTypesCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 15, right: 10),
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        width: MediaQuery.of(context).size.width * 0.3,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(blurRadius: 5, color: Colors.grey.shade400)],
        ),
        child: Column(
          children: [
            Image.asset(imagePath, height: 50),
            Text(title, style: TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}
