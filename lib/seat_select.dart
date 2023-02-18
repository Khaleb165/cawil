import 'package:cawil/passenger_details.dart';
import 'package:flutter/material.dart';

class SeatSelectPage extends StatefulWidget {
  const SeatSelectPage({Key? key}) : super(key: key);

  @override
  State<SeatSelectPage> createState() => _SeatSelectPageState();
}

class _SeatSelectPageState extends State<SeatSelectPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
        backgroundColor: Colors.deepPurple[50],
        body: SingleChildScrollView(
        child: Column(
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
          child: Align(
            alignment: Alignment.center,
            child: Text('Select your Seat',
            style: TextStyle(
              color: Colors.white,
              fontSize: 35,
              letterSpacing: 1.5
            ),),
          ),
        ),
          SizedBox(height: 15,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Card(
                    elevation: 20,
                    shadowColor: Colors.white,
                    color: Colors.white,
                    child: SizedBox(
                      width: 22,
                      height: 22,
                  )
                  ),
                  Text('Available',
                  style: TextStyle(
                    color: Color.fromRGBO(19, 41, 75, 1),
                    letterSpacing: 1.5
                  ),)
                ],
              ),
              Column(
                children: [
                  Card(
                      elevation: 20,
                      shadowColor: Colors.white,
                      color: Colors.greenAccent,
                      child: SizedBox(
                        width: 22,
                        height: 22,
                      )
                  ),
                  Text('Selected',
                    style: TextStyle(
                        color: Color.fromRGBO(19, 41, 75, 1),
                        letterSpacing: 1.5
                    ),)
                ],
              ),
              Column(
                children: [
                  Card(
                      elevation: 20,
                      shadowColor: Colors.white,
                      color: Color.fromRGBO(19, 41, 75, 1),
                      child: SizedBox(
                        width: 22,
                        height: 22,
                      )
                  ),
                  Text('Booked',
                    style: TextStyle(
                        color: Color.fromRGBO(19, 41, 75, 1),
                        letterSpacing: 1.5
                    ),)
                ],
              ),
            ],
          ),
          SizedBox(height: 50,),
          Padding(
            padding: const EdgeInsets.only(left: 50.0,right: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Card(
                    elevation: 20,
                    shadowColor: Colors.white,
                    color: Colors.white,
                    child: SizedBox(
                      width: 30,
                      height: 30,
                    )
                ),
                Card(
                    elevation: 20,
                    shadowColor: Colors.white,
                    color: Colors.white,
                    child: SizedBox(
                      width: 30,
                      height: 30,
                    )
                ),
                SizedBox(width: 20,),
                Card(
                    elevation: 20,
                    shadowColor: Colors.white,
                    color: Colors.white,
                    child: SizedBox(
                      width: 30,
                      height: 30,
                    )
                ),
                Card(
                    elevation: 20,
                    shadowColor: Colors.white,
                    color: Colors.white,
                    child: SizedBox(
                      width: 30,
                      height: 30,
                    )
                ),
              ],
            ),
          ),
          SizedBox(height: 5,),
          Padding(
            padding: const EdgeInsets.only(left: 50.0,right: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Card(
                    elevation: 20,
                    shadowColor: Colors.white,
                    color: Color.fromRGBO(19, 41, 75, 1),
                    child: SizedBox(
                      width: 30,
                      height: 30,
                    )
                ),
                Card(
                    elevation: 20,
                    shadowColor: Colors.white,
                    color: Color.fromRGBO(19, 41, 75, 1),
                    child: SizedBox(
                      width: 30,
                      height: 30,
                    )
                ),
                SizedBox(width: 20,),
                Card(
                    elevation: 20,
                    shadowColor: Colors.white,
                    color: Colors.white,
                    child: SizedBox(
                      width: 30,
                      height: 30,
                    )
                ),
                Card(
                    elevation: 20,
                    shadowColor: Colors.white,
                    color: Colors.white,
                    child: SizedBox(
                      width: 30,
                      height: 30,
                    )
                ),
              ],
            ),
          ),
          SizedBox(height: 5,),
          Padding(
            padding: const EdgeInsets.only(left: 50.0,right: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Card(
                    elevation: 20,
                    shadowColor: Colors.white,
                    color: Color.fromRGBO(19, 41, 75, 1),
                    child: SizedBox(
                      width: 30,
                      height: 30,
                    )
                ),
                Card(
                    elevation: 20,
                    shadowColor: Colors.white,
                    color: Color.fromRGBO(19, 41, 75, 1),
                    child: SizedBox(
                      width: 30,
                      height: 30,
                    )
                ),
                SizedBox(width: 20,),
                Card(
                    elevation: 20,
                    shadowColor: Colors.white,
                    color: Colors.white,
                    child: SizedBox(
                      width: 30,
                      height: 30,
                    )
                ),
                Card(
                    elevation: 20,
                    shadowColor: Colors.white,
                    color: Colors.white,
                    child: SizedBox(
                      width: 30,
                      height: 30,
                    )
                ),
              ],
            ),
          ),
          SizedBox(height: 5,),
          Padding(
            padding: const EdgeInsets.only(left: 50.0,right: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Card(
                    elevation: 20,
                    shadowColor: Colors.white,
                    color: Colors.greenAccent,
                    child: SizedBox(
                      width: 30,
                      height: 30,
                    )
                ),
                Card(
                    elevation: 20,
                    shadowColor: Colors.white,
                    color: Colors.white,
                    child: SizedBox(
                      width: 30,
                      height: 30,
                    )
                ),
                SizedBox(width: 20,),
                Card(
                    elevation: 20,
                    shadowColor: Colors.white,
                    color: Colors.greenAccent,
                    child: SizedBox(
                      width: 30,
                      height: 30,
                    )
                ),
                Card(
                    elevation: 20,
                    shadowColor: Colors.white,
                    color: Colors.white,
                    child: SizedBox(
                      width: 30,
                      height: 30,
                    )
                ),
              ],
            ),
          ),
          SizedBox(height: 5,),
          Padding(
            padding: const EdgeInsets.only(left: 50.0,right: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Card(
                    elevation: 20,
                    shadowColor: Colors.white,
                    color: Colors.white,
                    child: SizedBox(
                      width: 30,
                      height: 30,
                    )
                ),
                Card(
                    elevation: 20,
                    shadowColor: Colors.white,
                    color: Color.fromRGBO(19, 41, 75, 1),
                    child: SizedBox(
                      width: 30,
                      height: 30,
                    )
                ),
                SizedBox(width: 20,),
                Card(
                    elevation: 20,
                    shadowColor: Colors.transparent,
                    color: Colors.transparent,
                    child: SizedBox(
                      width: 30,
                      height: 30,
                    )
                ),
                Card(
                    elevation: 20,
                    shadowColor: Colors.transparent,
                    color: Colors.transparent,
                    child: SizedBox(
                      width: 30,
                      height: 30,
                    )
                ),
              ],
            ),
          ),
          SizedBox(height: 5,),
          Padding(
            padding: const EdgeInsets.only(left: 50.0,right: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Card(
                    elevation: 20,
                    shadowColor: Colors.white,
                    color: Color.fromRGBO(19, 41, 75, 1),
                    child: SizedBox(
                      width: 30,
                      height: 30,
                    )
                ),
                Card(
                    elevation: 20,
                    shadowColor: Colors.white,
                    color: Colors.white,
                    child: SizedBox(
                      width: 30,
                      height: 30,
                    )
                ),
                SizedBox(width: 20,),
                Card(
                    elevation: 20,
                    shadowColor: Colors.white,
                    color: Color.fromRGBO(19, 41, 75, 1),
                    child: SizedBox(
                      width: 30,
                      height: 30,
                    )
                ),
                Card(
                    elevation: 20,
                    shadowColor: Colors.white,
                    color: Colors.white,
                    child: SizedBox(
                      width: 30,
                      height: 30,
                    )
                ),
              ],
            ),
          ),
          SizedBox(height: 5,),
          Padding(
            padding: const EdgeInsets.only(left: 50.0,right: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Card(
                    elevation: 20,
                    shadowColor: Colors.white,
                    color: Colors.white,
                    child: SizedBox(
                      width: 30,
                      height: 30,
                    )
                ),
                Card(
                    elevation: 20,
                    shadowColor: Colors.white,
                    color: Colors.white,
                    child: SizedBox(
                      width: 30,
                      height: 30,
                    )
                ),
                SizedBox(width: 20,),
                Card(
                    elevation: 20,
                    shadowColor: Colors.white,
                    color: Colors.white,
                    child: SizedBox(
                      width: 30,
                      height: 30,
                    )
                ),
                Card(
                    elevation: 20,
                    shadowColor: Colors.white,
                    color: Color.fromRGBO(19, 41, 75, 1),
                    child: SizedBox(
                      width: 30,
                      height: 30,
                    )
                ),
              ],
            ),
          ),
          SizedBox(height: 30,),
      Container(
          padding: EdgeInsets.symmetric(horizontal: 35,vertical: 20),
          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.05),
          width: double.infinity,
          height: 200,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topRight: Radius.elliptical(20, 20),topLeft: Radius.elliptical(20, 20) ),
          ),
        child: Padding(
          padding: EdgeInsets.only(top: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Seat No: 13, 15',
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w500,
                color: Colors.deepPurple[300]
              ),),
              Text('Price: Ghc 160',
                style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w500,
                    color: Colors.deepPurple[300]
                ),),
              SizedBox(height: 10,),
              Center(
                child:  ElevatedButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => PassengerDetailsPage()));
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Color.fromRGBO(19, 41, 75, 1),
                    padding: EdgeInsets.symmetric(horizontal: 60,vertical: 15),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                  ),
                  child: Text('Continue',
                    style: TextStyle(
                      color: Colors.white,
                      letterSpacing: 1.5,
                      fontSize: 15

                    ),),
                ),
              ),
            ],
          ),
        ),
      ),

        ]),
        )
    );
  }
}
