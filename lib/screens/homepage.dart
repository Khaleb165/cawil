import 'package:cawil/constants/colors.dart';
import 'package:cawil/constants/size_config.dart';
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
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user != null) {
        getUsername();
      }
    });
  }

  Future<void> getUsername() async {
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      debugPrint('Fetching username for UID: $uid');

      DocumentSnapshot snap =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();

      debugPrint('Document exists: ${snap.exists}');
      debugPrint('Data: ${snap.data()}');

      if (snap.exists && snap.data() != null) {
        if (mounted) {
          setState(() {
            username =
                (snap.data() as Map<String, dynamic>)['username'] ?? 'User';
          });
        }
      } else {
        if (mounted) setState(() => username = 'User');
      }
    } catch (e) {
      debugPrint('Error fetching username: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenSize().init(context);
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Consumer<BusData>(builder: (context, busData, _) {
        return SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20),
                    vertical: getProportionateScreenHeight(20)),
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.0001),
                width: double.infinity,
                height: getProportionateScreenHeight(200),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [deepBlueColor, deepBlueColor, purpleColor],
                    tileMode: TileMode.clamp,
                  ),
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.elliptical(getProportionateScreenWidth(50),
                        getProportionateScreenHeight(40)),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: mainSpaceBetween,
                  children: [
                    Padding(
                        padding: EdgeInsets.only(
                            left: getProportionateScreenWidth(50))),
                    AppName(fontSize: getProportionateScreenHeight(50)),
                    SizedBox(width: getProportionateScreenWidth(50)),
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: getProportionateScreenHeight(20)),
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
                            size: getProportionateScreenHeight(30),
                            color: whiteColor,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(40)),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20)),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Hey ',
                          style: TextStyle(
                            fontSize: getProportionateScreenHeight(25),
                            color: blackColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: '$username,',
                          style: TextStyle(
                            fontSize: getProportionateScreenHeight(25),
                            color: blackColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(5)),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20)),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'what is your next trip?',
                    style: TextStyle(
                      fontSize: getProportionateScreenHeight(15),
                      color: lightBlackColor,
                    ),
                  ),
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(20)),
              Card(
                elevation: getProportionateScreenHeight(10),
                borderOnForeground: true,
                margin: EdgeInsets.all(getProportionateScreenHeight(20)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenHeight(10)),
                  child: Column(
                    crossAxisAlignment: crossStart,
                    children: [
                      headerText('From'),
                      buildCardFields(
                        sourceController,
                        TextInputAction.next,
                        greenAccentColor,
                        (newText) {
                          busData.updateFromTextField(newText);
                        },
                      ),
                      const Divider(thickness: 1),
                      headerText('To'),
                      buildCardFields(
                        destinationController,
                        TextInputAction.done,
                        darkBlueColor,
                        (newText) {
                          busData.updateToTextField(newText);
                        },
                      ),
                      SizedBox(height: getProportionateScreenHeight(15))
                    ],
                  ),
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(20)),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(30)),
                child: Material(
                  elevation: 5,
                  color: lightWhiteColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: SizedBox(
                    height: getProportionateScreenHeight(50),
                    width: getProportionateScreenWidth(250),
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: getProportionateScreenWidth(30),
                          right: getProportionateScreenWidth(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            DateFormat('dd/MM/yyyy').format(
                                Provider.of<BusData>(context).selectedDate),
                            style: TextStyle(
                              fontSize: getProportionateScreenHeight(15),
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
              SizedBox(height: getProportionateScreenHeight(30)),
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
                    padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(50),
                        vertical: getProportionateScreenHeight(15)),
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
              SizedBox(height: getProportionateScreenHeight(20)),
            ],
          ),
        );
      }),
    );
  }

  TextField buildCardFields(
      TextEditingController controller,
      TextInputAction textInputAction,
      Color textColor,
      void Function(String) onChanged) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      textInputAction: textInputAction,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: getProportionateScreenHeight(20),
        color: textColor,
      ),
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: whiteColor),
        ),
      ),
    );
  }

  Padding headerText(String text) {
    return Padding(
      padding: EdgeInsets.only(top: getProportionateScreenHeight(15)),
      child: Text(
        text,
        style: TextStyle(color: lightBlackColor),
      ),
    );
  }
}
