import 'dart:io';
import 'package:intl/intl.dart';
import 'package:event_booking_app/components/show_snakbar/show_snak_bar.dart';
import 'package:event_booking_app/services/data_base/data_base.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';

class UploadEventsPage extends StatefulWidget {
  const UploadEventsPage({super.key});

  @override
  State<UploadEventsPage> createState() => _UploadEventsPageState();
}

class _UploadEventsPageState extends State<UploadEventsPage> {
  TextEditingController eventNameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController detailController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  final List<String> evetnsCategory = [
    "Music",
    "Food",
    "Clothing",
    "Festivals",
  ];

  String? value;
  final ImagePicker _picker = ImagePicker();
  File? selectedImage;

  Future getImage() async {
    var image = await _picker.pickImage(source: ImageSource.gallery);

    selectedImage = File(image!.path);

    setState(() {});
  }

  DateTime selectedDateTime = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay(hour: 10, minute: 00);

  Future<void> pickDate() async {
    final DateTime? pickDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickDate != null && pickDate != selectedDateTime) {
      setState(() {
        selectedDateTime = pickDate;
      });
    }
  }

  String formateTimeOfDay(TimeOfDay) {
    final now = DateTime.now();
    final dateTime = DateTime(now.year, now.month, now.day, now.hour);
    return DateFormat('hh:mm a').format(dateTime);
  }

  Future<void> _picktime() async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null && pickedTime != selectedTime) {
      setState(() {
        selectedTime = pickedTime;
      });
    }
  }

  @override
  void dispose() {
    eventNameController.dispose();
    priceController.dispose();
    detailController.dispose();
    locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back_rounded, size: 30),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width / 6),
                  Text(
                    "Upload Events",
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 30),
              selectedImage != null
                  ? ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(20),
                      child: Image.file(
                        selectedImage!,
                        height: 180,
                        width: 200,
                        fit: BoxFit.cover,
                      ),
                    )
                  : InkWell(
                      onTap: () {
                        getImage();
                      },
                      child: Container(
                        height: 180,
                        width: 200,
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(22),
                        ),
                        child: Icon(Icons.camera_alt_rounded, size: 40),
                      ),
                    ),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "Event Name",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    TextFormField(
                      controller: eventNameController,
                      decoration: InputDecoration(
                        filled: true,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        hintText: "Enter event Name",
                        fillColor: Color(0xffececf8),
                      ),
                    ),
                    SizedBox(height: 30),
                    Row(
                      children: [
                        Text(
                          "Ticket Price",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    TextFormField(
                      controller: priceController,
                      decoration: InputDecoration(
                        filled: true,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        hintText: "Enter ticket Price",
                        fillColor: Color(0xffececf8),
                      ),
                    ),
                    SizedBox(height: 30),
                    Row(
                      children: [
                        Text(
                          "Location",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    TextFormField(
                      controller: locationController,
                      decoration: InputDecoration(
                        filled: true,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        hintText: "Enter location",
                        fillColor: Color(0xffececf8),
                      ),
                    ),

                    SizedBox(height: 30),
                    Row(
                      children: [
                        Text(
                          "Select Category",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 8,
                      ),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color(0xffececf8),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          items: evetnsCategory
                              .map(
                                (items) => DropdownMenuItem(
                                  value: items,
                                  child: Text(
                                    items,
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: ((newValue) => setState(() {
                            value = newValue;
                          })),

                          dropdownColor: Colors.white,
                          hint: Text("Select Category"),
                          iconSize: 36,
                          icon: Icon(
                            Icons.arrow_downward_rounded,
                            color: Colors.black,
                          ),
                          value: value,
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            pickDate();
                          },
                          icon: Icon(
                            Icons.calendar_month_rounded,
                            color: Colors.blue,
                            size: 35,
                          ),
                        ),
                        Text(
                          DateFormat('yyyy-MM-dd').format(selectedDateTime),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 10),
                        IconButton(
                          onPressed: () {
                            _picktime();
                          },
                          icon: Icon(
                            Icons.alarm_rounded,
                            color: Colors.blue,
                            size: 35,
                          ),
                        ),
                        Text(
                          DateFormat('yyyy-MM-dd').format(selectedDateTime),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    Row(
                      children: [
                        Text(
                          "Events details",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    TextFormField(
                      controller: detailController,
                      maxLines: 8,
                      decoration: InputDecoration(
                        filled: true,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        hintText: "write about event....",
                        fillColor: Color(0xffececf8),
                      ),
                    ),

                    SizedBox(height: 30),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        maximumSize: Size(200, 100),
                        backgroundColor: Color(0xff6351ec),
                      ),
                      onPressed: () async {
                        // String addId = randomAlphaNumeric(10);
                        // Reference firebaseStorageRef = FirebaseStorage.instance
                        //     .ref()
                        //     .child("blogImages")
                        //     .child("addId");

                        // final UploadTask task = firebaseStorageRef.putFile(
                        //   selectedImage!,
                        // );

                        // var downloadUrl = await (await task).ref
                        //     .getDownloadURL();

                        String id = randomAlphaNumeric(10);
                        Map<String, dynamic> uploadEvent = {
                          "Image": "",
                          "Name": eventNameController.text,
                          "price": priceController.text,
                          "Category": value,
                          "events Details": detailController.text,
                          "Date": DateFormat(
                            'yyyy-MM-dd',
                          ).format(selectedDateTime),
                          "Time": formateTimeOfDay(selectedTime),
                          "Location": locationController.text,
                        };

                        await DataBaseMethods().addEvents(uploadEvent, id).then(
                          (value) {
                            showSnakBar(context, "Event upload sucessfully");
                            setState(() {
                              eventNameController.text = "";
                              priceController.text = "";
                              detailController.text = "";
                              locationController.text = "";
                              selectedImage = null;
                            });
                          },
                        );
                      },
                      child: Text(
                        "Upload",
                        style: TextStyle(color: Colors.white, fontSize: 22),
                      ),
                    ),
                    SizedBox(height: 30),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
