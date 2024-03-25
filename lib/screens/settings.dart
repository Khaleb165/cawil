import 'package:cawil/constants/colors.dart';
import 'package:cawil/resources/auth_methods.dart';
import 'package:cawil/screens/auth_screens/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  final String uid;

  const SettingsPage({Key? key, required this.uid}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String username = '';
  String email = '';

  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    setState(() {
      username = (snap.data() as Map<String, dynamic>)['username'];
      email = (snap.data() as Map<String, dynamic>)['email'];
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
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [shade1, shade1, shade2],
                  tileMode: TileMode.clamp,
                ),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.elliptical(50, 50),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.notes_sharp,
                              size: 30,
                              color: Colors.white,
                            )),
                      ),
                      SizedBox(width: 70),
                      Padding(
                        padding: const EdgeInsets.only(top: 45.0),
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Text(
                            'SETTINGS',
                            style: TextStyle(
                              letterSpacing: 3,
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage:
                            AssetImage('assets/defaultProfile.jpeg'),
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '$username',
                            style: TextStyle(
                                fontSize: 25,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2.5),
                          ),
                          SizedBox(height: 1),
                          Text(
                            '$email',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.w200,
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 30),
            Column(
              children: [
                settingsListTile(() {}, 'assets/person1.png', 'Account'),
                SizedBox(height: 20),
                settingsListTile(() {}, 'assets/bell.png', 'Notifications'),
                SizedBox(height: 20),
                settingsListTile(() {}, 'assets/location.png', 'Location'),
                SizedBox(height: 20),
                settingsListTile(() {}, 'assets/person1.png', 'Support'),
                SizedBox(height: 20),
                settingsListTile(() {}, 'assets/share.png', 'Share'),
                SizedBox(height: 20),
                settingsListTile(() async {
                  await AuthMethods().signOut();
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                }, 'assets/loggg.png', 'Logout'),
              ],
            )
          ],
        ),
      ),
    );
  }

  InkWell settingsListTile(VoidCallback, String imageText, String title) {
    return InkWell(
      onTap: VoidCallback,
      child: ListTile(
        leading: CircleAvatar(
          radius: 18,
          backgroundColor: Colors.deepPurple[300],
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Image.asset(imageText),
          ),
        ),
        title: Text(
          title,
          style: TextStyle(fontSize: 19, color: Colors.black54),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: Colors.deepPurple[300],
          size: 18,
        ),
      ),
    );
  }
}
