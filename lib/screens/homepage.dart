// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:cawil/screens/bus_page.dart';
import 'package:cawil/screens/settings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomepageScreen extends StatefulWidget {
  const HomepageScreen({Key? key}) : super(key: key);

  @override
  State<HomepageScreen> createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> {
  TextEditingController sourceController = TextEditingController();
  TextEditingController destinationController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  String username = '';

  @override
  void initState() {
    getUsername();
    super.initState();
  }

  void getUsername() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    setState(() {
      username = (snap.data() as Map<String, dynamic>)['username'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.deepPurple[50],
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 35, vertical: 20),
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.0001),
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color.fromRGBO(0, 7, 240, 0.5),
                      Color.fromRGBO(0, 7, 240, 0.5),
                      Color.fromRGBO(127, 0, 255, 100)
                    ],
                    tileMode: TileMode.clamp,
                  ),
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.elliptical(50, 50),
                      bottomLeft: Radius.elliptical(50, 50)),
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(padding: EdgeInsets.only(left: 55)),
                      Text(
                        'Ca',
                        style: TextStyle(
                            fontSize: 50,
                            color: Colors.greenAccent,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Wil',
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(19, 41, 75, 1),
                        ),
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SettingsPage(
                                              uid: '',
                                            )));
                              },
                              icon: Icon(
                                Icons.notes_sharp,
                                size: 30,
                                color: Colors.white,
                              )),
                        ),
                      )
                    ]),
              ),
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: EdgeInsets.only(left: 45, right: 15),
                child: Row(
                  children: [
                    Text(
                      'Hey ',
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '$username,',
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.only(left: 0, right: 85),
                child: Text(
                  'what is your next trip?',
                  style: TextStyle(fontSize: 22, color: Colors.black38),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Card(
                elevation: 15,
                borderOnForeground: true,
                margin: EdgeInsets.fromLTRB(25, 25, 25, 25),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Container(
                  height: 220,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30.0, right: 30),
                    child: Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 18.0),
                            child: Text(
                              'From',
                              style: TextStyle(color: Colors.black26),
                            ),
                          ),
                          Expanded(
                            child: TextField(
                              controller: sourceController,
                              textInputAction: TextInputAction.next,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                  color: Colors.greenAccent),
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.white, width: 0.0),
                                ),
                              ),
                            ),
                          ),
                          Divider(
                            thickness: 1,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Text(
                              'To',
                              style: TextStyle(color: Colors.black26),
                            ),
                          ),
                          Expanded(
                            child: TextField(
                              controller: destinationController,
                              textInputAction: TextInputAction.done,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                color: Color.fromRGBO(19, 41, 75, 1),
                              ),
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.white, width: 0.0),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30.0, right: 30),
                child: Material(
                  elevation: 5,
                  color: const Color.fromARGB(255, 253, 251, 255),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  child: SizedBox(
                    height: 50,
                    width: 350,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 40, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            DateFormat('dd/MM/yyyy').format(selectedDate),
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 1.5,
                                fontStyle: FontStyle.normal),
                          ),
                          Spacer(),
                          IconButton(
                            icon: Icon(
                              Icons.calendar_month_outlined,
                              color: Color.fromRGBO(19, 41, 75, 1),
                            ),
                            onPressed: () => _selectDate(context),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BusPage(
                                  source: sourceController.text,
                                  destination: destinationController.text,
                                  date: selectedDate,
                                )));
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Color.fromRGBO(19, 41, 75, 1),
                    padding: EdgeInsets.symmetric(horizontal: 80, vertical: 18),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                  ),
                  child: Text(
                    'FIND YOUR BUS',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
