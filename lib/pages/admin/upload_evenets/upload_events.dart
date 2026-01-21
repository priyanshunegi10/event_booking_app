import 'package:flutter/material.dart';

class UploadEventsPage extends StatefulWidget {
  const UploadEventsPage({super.key});

  @override
  State<UploadEventsPage> createState() => _UploadEventsPageState();
}

class _UploadEventsPageState extends State<UploadEventsPage> {
  final List<String> evetnsCategory = [
    "Music",
    "Food",
    "Clothing",
    "Festivals",
  ];

  String? value;

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
              Container(
                height: 180,
                width: 200,
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(22),
                ),
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.camera_alt_rounded, size: 40),
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
                          onChanged: ((value) => setState(() {
                            this.value;
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
                      onPressed: () {},
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
