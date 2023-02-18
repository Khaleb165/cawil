// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cawil/homepage.dart';
import 'package:cawil/login.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
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

                  InkWell(
                     // onTap: (){},
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 35,
                          backgroundImage: AssetImage('assets/profile.jpg'),
                        ),
                        title: Text('Nana Caleb',
                          style: TextStyle(
                              fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                          ),),
                        subtitle: Text("nana1234@gmail.com",
                          style: TextStyle(
                            fontSize: 13.5,
                            color: Colors.white38
                          ),),
                        trailing: IconButton(
                          onPressed: (){},
                          icon: Icon(Icons.edit_note_sharp,color: Colors.white,size: 35,),
                        ),
                      )
                  ),


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
                    //  Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
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
