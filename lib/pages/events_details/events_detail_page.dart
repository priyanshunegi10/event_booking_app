import 'package:event_booking_app/components/show_snakbar/show_snak_bar.dart';
import 'package:event_booking_app/pages/events_details/widgets/concerts_image.dart';
import 'package:event_booking_app/services/APIs/data.dart';
import 'package:event_booking_app/services/data_base/data_base.dart';
import 'package:event_booking_app/services/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_stripe/flutter_stripe.dart';
import 'dart:convert';

class EventsDetailPage extends StatefulWidget {
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
  State<EventsDetailPage> createState() => _EventsDetailPageState();
}

class _EventsDetailPageState extends State<EventsDetailPage> {
  Map<String, dynamic>? paymentIntent;
  int ticket = 1;

  int total = 0;
  String? username, image, userId;

  @override
  void initState() {
    total = int.parse(widget.price) * ticket;
    onTheLoad();
    super.initState();
  }

  Future onTheLoad() async {
    username = await SharedPrefrenceHelper().getUserName();
    image = await SharedPrefrenceHelper().getUserImage();
    userId = await SharedPrefrenceHelper().getUserId();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ConcertsImage(
              image: widget.image,
              date: widget.date,
              location: widget.location,
              title: widget.title,
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
                  Text(widget.details, style: TextStyle(fontSize: 15)),
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
                        padding: EdgeInsets.symmetric(vertical: 6),
                        height: 130,
                        width: 60,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1.5),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                total = total + int.parse(widget.price);

                                ticket++;
                                setState(() {});
                              },
                              child: Text(
                                "+",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(
                              ticket.toString(),
                              style: TextStyle(
                                color: Color(0xff6351ec),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                total = total - int.parse(widget.price);
                                if (ticket > 1) {
                                  ticket--;
                                  setState(() {});
                                }
                              },
                              child: Text(
                                "-",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
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
                      Text(
                        "Amount : \$${total.toString()}",
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xff6351ec),
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      Spacer(),
                      InkWell(
                        onTap: () {
                          makePayment(total.toString());
                        },
                        child: Container(
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

  Future<void> makePayment(String amount) async {
    try {
      paymentIntent = await createPaymentIntent(amount, 'INR');

      await Stripe.instance
          .initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: paymentIntent!['client_secret'],
              style: ThemeMode.dark,
              merchantDisplayName: 'Adnan',
            ),
          )
          .then((value) {});
      displayPaymentSheet(amount);
    } catch (e, s) {
      print(e);
      print(s);
      showSnakBar(context, "Payment Error: $e");
    }
  }

  Future displayPaymentSheet(String amount) async {
    try {
      await Stripe.instance
          .presentPaymentSheet()
          .then((value) async {
            Map<String, dynamic> bookingDetails = {
              "Number of tickets": ticket.toString(),
              "Total": total.toString(),
              "Event": widget.title,
              "Location": widget.location,
              "Date": widget.date,
              "Name": username,
              "Image": image,
              "UserId": userId,
              "Event image": widget.image,
            };

            await DataBaseMethods()
                .addUserBooking(bookingDetails, userId!)
                .then((value) async {
                  await DataBaseMethods().addAdminBookins(bookingDetails);
                });

            showDialog(
              context: context,
              builder: (_) => AlertDialog(
                content: Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.check_circle, color: Colors.green),
                        Text("Payment Successful"),
                      ],
                    ),
                  ],
                ),
              ),
            );
            paymentIntent = null;
          })
          .onError((error, stackTrace) {
            showSnakBar(context, "Error is :----> $error $stackTrace");
          });
    } on StripeException catch (e) {
      showSnakBar(context, e.toString());
    }
  }

  Future createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        "amount": calculateAmount(amount),
        "currency": currency,
        "payment_method_types[]": "card",
      };

      var response = await http.post(
        Uri.parse("https://api.stripe.com/v1/payment_intents"),
        headers: {
          "Authorization": "Bearer $secretKey", // ✅ Spelling check karein
          "Content-Type": "application/x-www-form-urlencoded",
        },
        body: body,
      );

      // 👇 YEH LINE ERROR PAKDEGI
      print("Stripe Response Code: ${response.statusCode}");
      print("Stripe Response Body: ${response.body}");

      if (response.statusCode != 200) {
        throw Exception("Failed to create PaymentIntent: ${response.body}");
      }

      return jsonDecode(response.body);
    } catch (e) {
      print("Error in createPaymentIntent: $e");
      // User ko bhi dikhayein
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Stripe Error: $e")));
    }
  }

  String calculateAmount(String amount) {
    final calculatedAmount = (int.parse(amount)) * 100;

    return calculatedAmount.toString();
  }
}
