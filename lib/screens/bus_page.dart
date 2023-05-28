// ignore_for_file: unused_import

import 'package:cawil/screens/components/TicketCard.dart';
import 'package:cawil/screens/seat_select.dart';
import 'package:cawil/screens/settings.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';


class BusPage extends StatefulWidget {
  const BusPage({Key? key}) : super(key: key);

  @override
  State<BusPage> createState() => _BusPageState();
}

class _BusPageState extends State<BusPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
        backgroundColor: Colors.deepPurple[50],
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 35,vertical: 20),
              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.0001),
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [const Color.fromRGBO(0, 7, 240,0.5),Color.fromRGBO(0, 7, 240,0.5), Color.fromRGBO(127,0,255,100)],
                  tileMode: TileMode.clamp,
                ),
                borderRadius: BorderRadius.only(bottomRight: Radius.elliptical(50, 50),bottomLeft:Radius.elliptical(50, 50) ),
              ),
              child:  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(padding: EdgeInsets.only(left: 55)),
                    Text('Ca',
                      style: TextStyle(
                          fontSize: 50,
                          color: Colors.greenAccent,
                          fontWeight: FontWeight.bold
                      ),),
                    Text('Wil',
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(19, 41, 75, 1),
                      ),),

                   // SizedBox(width: 50,),
                    ///
                    /// Align(
                    //                         alignment: Alignment.topRight,
                    //                         child: Padding(
                    //                           padding: const EdgeInsets.only(top: 20.0),
                    //                           child: IconButton(onPressed: (){
                    //                             Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage()));
                    //                           },
                    //                               icon: Icon(Icons.notes_sharp,size: 30,color: Colors.white,)
                    //                           ),
                    //                         ),
                    //                       )
                    ///

                  ]
              ),
            ),
            SizedBox(height: 10,),
            Container(height: 150,
            width: double.infinity,
            child: Column(
              children: [
                Image.asset('assets/bus-logo.png',scale: 4,),
                SizedBox(height:10,),
                Text('2 Buses Available',
                  style: TextStyle(
                      fontSize: 35,
                      color: Color.fromRGBO(19, 41, 75, 1),
                      fontWeight: FontWeight.bold
                  ),),
              ],
            ),),

            SizedBox(height: 15,),




            ],
        )
    );
  }
}
