// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import

import 'dart:typed_data';

import 'package:cawil/resources/auth_methods.dart';
import 'package:cawil/screens/homepage.dart';
import 'package:cawil/screens/login.dart';
import 'package:cawil/utilities/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  Uint8List? _image;

  void selectImage() async{
    Uint8List image = await pickImage(ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  String username = '';
  String email = '';

  @override
  void initState() {
    getUsername();
    super.initState();
  }

  void getUsername() async{
    DocumentSnapshot snap = await FirebaseFirestore.instance.collection('users').
    doc(FirebaseAuth.instance.currentUser!.uid)
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
              padding: EdgeInsets.symmetric(horizontal: 35,vertical: 20),
              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.0001),
              width: double.infinity,
              height: 250,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [const Color.fromRGBO(0, 7, 240,0.5),Color.fromRGBO(0, 7, 240,0.5), Color.fromRGBO(127,0,255,100)],
                  tileMode: TileMode.clamp,
                ),
                borderRadius: BorderRadius.only(bottomRight: Radius.elliptical(50, 50),bottomLeft:Radius.elliptical(50, 50) ),
              ),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:[

                      Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: IconButton(onPressed: (){
                        Navigator.pop(context, MaterialPageRoute(builder: (context) => HomepageScreen()));
                    },
                          icon: Icon(Icons.notes_sharp,size: 30,color: Colors.white,)
                    ),
                      ),
                      SizedBox(width: 70,),
                      Padding(
                        padding: const EdgeInsets.only(top: 45.0),
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Text('SETTINGS',
                          style: TextStyle(
                            letterSpacing: 3,
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                          ),),
                        ),
                      )
      ]
                  ),
                  SizedBox(height: 30,),

                  Row(
                    children: [
                      Stack(
                        children: [
                          _image != null
                          ? CircleAvatar(
                    radius: 40,
                    backgroundImage: MemoryImage(_image!),
                  )
                           : CircleAvatar(
                            radius: 30,
                            backgroundImage: AssetImage('assets/defaultProfile.jpeg'),
                          ),
                          // Positioned(
                          //   bottom: -10,
                          //     left: 40,
                          //     child: IconButton(
                          //   onPressed: selectImage,
                          //   icon: Icon(Icons.add_a_photo,color: Colors.white,size: 22,),
                          // )
                          // )
                        ],
                      ),
                      SizedBox(width: 10,),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('$username',
                            style: TextStyle(
                                fontSize: 25,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              letterSpacing: 2.5
                            ),
                          ),
                          SizedBox(height: 1,),

                          Text('$email',
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.w200
                            ),
                          ),
                        ],
                      ),
                    ],
                  )

                ],
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 35),
            child: Column(
              children: [
                InkWell(
                   onTap: (){},
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.deepPurple[300],
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Image.asset('assets/person1.png'),
                          ),
                      ),
                      title: Text('Account',
                        style: TextStyle(
                            fontSize: 19,
                            color: Colors.black54
                        ),),

                      trailing: Icon(Icons.arrow_forward_ios,color: Colors.deepPurple[300],size: 18,),

                    )
                ),
                SizedBox(height: 20,),
                InkWell(
                    onTap: (){},
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.deepPurple[300],
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: Image.asset('assets/bell.png',),
                        ),
                      ),
                      title: Text('Notifications',
                        style: TextStyle(
                            fontSize: 19,
                            color: Colors.black54
                        ),),

                      trailing: Icon(Icons.arrow_forward_ios,color: Colors.deepPurple[300],size: 18,),

                    )
                ),
                SizedBox(height: 20,),
                InkWell(
                    onTap: (){},
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.deepPurple[300],
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Image.asset('assets/location.png'),
                        ),
                      ),
                      title: Text('Location',
                        style: TextStyle(
                            fontSize: 19,
                            color: Colors.black54
                        ),),

                      trailing: Icon(Icons.arrow_forward_ios,color: Colors.deepPurple[300],size: 18,),

                    )
                ),
                SizedBox(height: 20,),
                InkWell(
                    onTap: (){},
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.deepPurple[300],
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Image.asset('assets/person1.png'),
                        ),
                      ),
                      title: Text('Support',
                        style: TextStyle(
                            fontSize: 19,
                            color: Colors.black54
                        ),),

                      trailing: Icon(Icons.arrow_forward_ios,color: Colors.deepPurple[300],size: 18,),

                    )
                ),
                SizedBox(height: 20,),
                InkWell(
                    onTap: (){},
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.deepPurple[300],
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Image.asset('assets/share.png'),
                        ),
                      ),
                      title: Text('Share',
                        style: TextStyle(
                            fontSize: 19,
                            color: Colors.black54
                        ),),

                      trailing: Icon(Icons.arrow_forward_ios,color: Colors.deepPurple[300],size: 18,),

                    )
                ),
                SizedBox(height: 20,),
                InkWell(
                    onTap: (){

                      Navigator.pop(context);
                      Navigator.pop(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                    },
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.deepPurple[300],
                        child: Padding(
                          padding: const EdgeInsets.all(7.0),
                          child: Image.asset('assets/loggg.png'),
                        ),
                      ),
                      title: Text('Logout',
                        style: TextStyle(
                            fontSize: 19,
                            color: Colors.black54
                        ),),

                      trailing: Icon(Icons.arrow_forward_ios,color: Colors.deepPurple[300],size: 18,),

                    )
                ),

              ],
            ),
            )
          ],
        ),
      ),
    );
  }
}
