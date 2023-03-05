import 'package:flutter/material.dart';

class PassengerDetailsPage extends StatefulWidget {
  const PassengerDetailsPage({Key? key}) : super(key: key);

  @override
  State<PassengerDetailsPage> createState() => _PassengerDetailsPageState();
}

class _PassengerDetailsPageState extends State<PassengerDetailsPage> {
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
            child: Text('Passenger Details',
            style: TextStyle(
            color: Colors.white,
            fontSize: 35,
            letterSpacing: 1
            ),),
          ),
          ),
          SizedBox(height: 90,),

          Padding(
            padding: const EdgeInsets.only(left: 30.0,right: 30),
            child: Material(
              elevation: 0,
              borderRadius: BorderRadius.circular(30),
              child: TextField(
                textInputAction: TextInputAction.next,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      // width: 0.0 produces a thin "hairline" border
                      borderSide: const BorderSide(color: Colors.white, width: 0.0),
                      borderRadius: BorderRadius.circular(15),
                    ),

                    labelText: 'Name of traveller',
                    //hintText: 'DD/MM/YYYY',
                    labelStyle: TextStyle(color: Colors.black45,),
                    filled: true,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(width:1,style: BorderStyle.solid,color: Colors.black38)
                    )

                ),
              ),
            ),
          ),
          SizedBox(height: 15,),
          Padding(
            padding: const EdgeInsets.only(left: 30.0,right: 30),
            child: Material(
              elevation: 0,
              borderRadius: BorderRadius.circular(30),
              child: TextField(
                textInputAction: TextInputAction.next,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      // width: 0.0 produces a thin "hairline" border
                      borderSide: const BorderSide(color: Colors.white, width: 0.0),
                      borderRadius: BorderRadius.circular(15),
                    ),

                    labelText: 'Phone Number',
                    //hintText: 'DD/MM/YYYY',
                    labelStyle: TextStyle(color: Colors.black45,),
                    filled: true,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(width:1,style: BorderStyle.solid,color: Colors.black38)
                    )

                ),
              ),
            ),
          ),
          SizedBox(height: 15,),
          Padding(
            padding: const EdgeInsets.only(left: 30.0,right: 30),
            child: Material(
              elevation: 0,
              borderRadius: BorderRadius.circular(30),
              child: TextField(
                textInputAction: TextInputAction.next,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      // width: 0.0 produces a thin "hairline" border
                      borderSide: const BorderSide(color: Colors.white, width: 0.0),
                      borderRadius: BorderRadius.circular(15),
                    ),

                    labelText: 'Gender',
                    //hintText: 'DD/MM/YYYY',
                    labelStyle: TextStyle(color: Colors.black45,),
                    filled: true,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(width:1,style: BorderStyle.solid,color: Colors.black38)
                    )

                ),
              ),
            ),
          ),
          SizedBox(height: 15,),
          Padding(
            padding: const EdgeInsets.only(left: 30.0,right: 30),
            child: Material(
              elevation: 0,
              borderRadius: BorderRadius.circular(30),
              child: TextField(
                textInputAction: TextInputAction.next,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      // width: 0.0 produces a thin "hairline" border
                      borderSide: const BorderSide(color: Colors.white, width: 0.0),
                      borderRadius: BorderRadius.circular(15),
                    ),

                    labelText: 'Guardian Name',
                    //hintText: 'DD/MM/YYYY',
                    labelStyle: TextStyle(color: Colors.black45,),
                    filled: true,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(width:1,style: BorderStyle.solid,color: Colors.black38)
                    )

                ),
              ),
            ),
          ),
          SizedBox(height: 16,),
          Padding(
            padding: const EdgeInsets.only(left: 30.0,right: 30),
            child: Material(
              elevation: 0,
              borderRadius: BorderRadius.circular(30),
              child: TextField(
                textInputAction: TextInputAction.done,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      // width: 0.0 produces a thin "hairline" border
                      borderSide: const BorderSide(color: Colors.white, width: 0.0),
                      borderRadius: BorderRadius.circular(15),
                    ),

                    labelText: 'Guardian Phone Number',
                    //hintText: 'DD/MM/YYYY',
                    labelStyle: TextStyle(color: Colors.black45,),
                    filled: true,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(width:1,style: BorderStyle.solid,color: Colors.black38)
                    )

                ),
              ),
            ),
          ),
          SizedBox(height: 40,),
          Center(
            child:  ElevatedButton(
              onPressed: (){
               // Navigator.push(context, MaterialPageRoute(builder: (context) => PassengerDetailsPage()));
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.greenAccent,
                padding: EdgeInsets.symmetric(horizontal: 90,vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                elevation: 0
              ),
              child: Text('Proceed to Payment',
                style: TextStyle(
                    color: Colors.white,
                    letterSpacing: 1,
                    fontSize: 15,
                  fontWeight: FontWeight.w400

                ),),
            ),
          ),
    ])
    )
    );
  }
}
