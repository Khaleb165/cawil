import 'package:cawil/constants/colors.dart';
import 'package:cawil/widgets/app_name.dart';
import 'package:cawil/providers/bus_data.dart';
import 'package:cawil/screens/available_bus_page.dart';
import 'package:cawil/screens/settings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  TextEditingController sourceController = TextEditingController();
  TextEditingController destinationController = TextEditingController();

  // DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final busData = Provider.of<BusData>(context, listen: false);

    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: busData.selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (date != null && date != busData.selectedDate)
      setState(() {
        busData.updateSelectedDate(date);
      });
  }

  String username = '';

  @override
  void initState() {
    getUsername();
    super.initState();
  }

  Future<void> getUsername() async {
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
      body: Consumer<BusData>(builder: (context, busData, _) {
        return SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 35, vertical: 20),
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.0001),
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [deepBlueColor, deepBlueColor, purpleColor],
                    tileMode: TileMode.clamp,
                  ),
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.elliptical(50, 50),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 55),
                    ),
                    const AppName(fontSize: 50),
                    const SizedBox(width: 50),
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SettingsPage(
                                  uid: '',
                                ),
                              ),
                            );
                          },
                          icon: Icon(
                            Icons.notes_sharp,
                            size: 30,
                            color: whiteColor,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.only(right: 110),
                child: RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: 'Hey ',
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: '$username,',
                        style: const TextStyle(
                          fontSize: 30,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.only(right: 85),
                child: Text(
                  'what is your next trip?',
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.black38,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Card(
                elevation: 15,
                borderOnForeground: true,
                margin: const EdgeInsets.all(25),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      headerText('From'),
                      buildCardFields(sourceController, TextInputAction.next,
                          greenAccentColor, (newText) {
                        busData.updateFromTextField(newText);
                      }),
                      const Divider(thickness: 1),
                      headerText('To'),
                      buildCardFields(destinationController,
                          TextInputAction.done, darkBlueColor, (newText) {
                        busData.updateToTextField(newText);
                      }),
                      const SizedBox(height: 5)
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
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
                            DateFormat('dd/MM/yyyy').format(
                                Provider.of<BusData>(context).selectedDate),
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 1.5,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            icon: Icon(
                              Icons.calendar_month_outlined,
                              color: darkBlueColor,
                            ),
                            onPressed: () => _selectDate(context),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AvailableBusPage(),
                      ),
                    );
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: darkBlueColor,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 80, vertical: 18),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                  ),
                  child: Text(
                    'FIND YOUR BUS',
                    style: TextStyle(
                      color: whiteColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  TextField buildCardFields(
      TextEditingController controller,
      TextInputAction inputAction,
      Color textColor,
      void Function(String) onChanged) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      textInputAction: TextInputAction.next,
      style: TextStyle(
          fontWeight: FontWeight.bold, fontSize: 25, color: textColor),
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: whiteColor,
          ),
        ),
      ),
    );
  }

  Padding headerText(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 18.0),
      child: Text(
        text,
        style: const TextStyle(color: Colors.black38),
      ),
    );
  }
}
