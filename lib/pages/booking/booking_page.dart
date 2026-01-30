import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_booking_app/services/data_base/data_base.dart';
import 'package:event_booking_app/services/shared_pref.dart';
import 'package:flutter/material.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  Stream? bookingStream;
  String? id;

  Future onTheLoad() async {
    // 1. User ID nikalo
    id = await SharedPrefrenceHelper().getUserId();

    // Debugging ke liye: Console me check karna ID print ho rahi hai ya nahi
    print("Current User ID: $id");

    if (id != null) {
      // 2. Agar ID mili, toh data mangwao
      bookingStream = await DataBaseMethods().getBooking(id!);
    } else {
      print("User ID nahi mili! Shayad user logout ho gaya hai.");
    }

    // 3. IMPORTANT: UI ko refresh karo (chahe ID mile ya na mile)
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
      body: Container(
        // Move Gradient here to cover full background
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xffe3e6ff), Color(0xfff1f3ff), Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 10),
              Center(
                child: Text(
                  "My Bookings",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 20),
              // Use Expanded to fill the rest of the screen
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                  ),

                  child: StreamBuilder(
                    stream: bookingStream,
                    builder: (context, AsyncSnapshot snapshot) {
                      // 3. FIXED LOGIC: Show loader if NO data
                      if (!snapshot.hasData) {
                        return Center(child: CircularProgressIndicator());
                      }

                      // 4. Handle empty list case
                      if (snapshot.data.docs.length == 0) {
                        return Center(child: Text("No bookings yet!"));
                      }

                      return ListView.builder(
                        padding: EdgeInsets.zero,
                        // Removed shrinkWrap/physics to let it scroll naturally
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot ds = snapshot.data.docs[index];
                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            margin: EdgeInsets.only(bottom: 20),
                            decoration: BoxDecoration(
                              // Added explicit color so shadow/border works
                              color: Colors.white,
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Row(
                              // Changed Column to Row for better layout
                              children: [
                                // Image Section
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.asset(
                                    ds["Event image"], 
                                    height: 150,
                                    width: 160,
                                    fit: BoxFit.cover,
                                  ),
                                ),

                                // Details Section
                                Expanded(
                                  // Prevents overflow
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          ds["Event"],
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(height: 5),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.location_on_outlined,
                                              size: 18,
                                              color: Colors.grey,
                                            ),
                                            SizedBox(width: 5),
                                            Expanded(
                                              child: Text(
                                                ds["Location"],
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.grey[700],
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.calendar_month_rounded,
                                              size: 18,
                                              color: Colors.blue,
                                            ),
                                            SizedBox(width: 5),
                                            Text(
                                              ds["Date"],
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons
                                                  .confirmation_number_outlined,
                                              size: 18,
                                              color: Colors.blue,
                                            ),
                                            SizedBox(width: 5),
                                            Text(
                                              "Tickets: ${ds["Number of tickets"]}",
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          "Paid: \$${ds["Total"]}",
                                          style: TextStyle(
                                            color: Color(0xff6351ec),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
