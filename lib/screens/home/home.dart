import 'package:flutter/material.dart';
import 'package:home_cure/screens/community/community.dart';
import 'package:home_cure/screens/home/house_patrol.dart';
import 'package:home_cure/screens/home/incident_report.dart';
import 'package:home_cure/screens/home/suspicious_report.dart';
import 'package:home_cure/screens/message/message.dart';
import 'package:home_cure/screens/profile/profile.dart';
import 'dart:ui' as ui;
import 'dart:math' as math;
import 'entry_registration.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final screens = [
      MyHome(),
      Community(),
      Message(),
      Profile(),
    ];
    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }

    return Scaffold(
      backgroundColor: Colors.blue[30],
      body: IndexedStack(
        index: _selectedIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor:  Color(0xFF2D82B5),
        unselectedItemColor: Colors.blue[100],
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: "Community"),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: "Message"),
          BottomNavigationBarItem(
              icon: Icon(Icons.people_rounded), label: "Profile"),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

//widget for home page
class MyHome extends StatelessWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
            "HomeCure",
            style: TextStyle(
                fontFamily: 'Noto',
                color: Colors.white,
                letterSpacing: 2,
                fontWeight: FontWeight.bold,
                fontSize: 28)
        ),
        centerTitle: true,
        backgroundColor: Colors.lightBlueAccent[100],

      ),
      body: Center(
        child: Container(
          //padding:  EdgeInsets.all(10.0),
          margin: EdgeInsets.fromLTRB(20, 0,20, 0),
          //color: Colors.grey[400],
          child:  Column(
            children: [
              SizedBox(height: 20),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height:135, //height of button
                      width:150,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xFFC9D9E8),
                              spreadRadius: 0,
                              blurRadius: 16,
                              offset: Offset(8, 8),
                            ),
                            BoxShadow(
                              color: Color(0xFFFFFFFF),
                              spreadRadius: 0,
                              blurRadius: 16,
                              offset: Offset(-8, -8),
                            )
                          ]
                      ),
//Rider/Visitor Button
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const EntryRegistration()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFFF1F5F9), // Background color
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(height: 20),
                              Icon(
                                Icons.bike_scooter,
                                size: 60,
                                color: Color(0xFF2D82B5).withOpacity(0.7),
                              ),
                              SizedBox(height: 5),
                              Text(
                                  'Rider/Visitor Registration',
                                  style: TextStyle(
                                      fontFamily: 'Inter',
                                      color: Color(0xFF015C92),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16)
                              ),
                            ],
                          )),
                    ),
                    SizedBox(width: 20),
                    Container(
                      height:135, //height of button
                      width:150,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xFFC9D9E8),
                              spreadRadius: 0,
                              blurRadius: 16,
                              offset: Offset(8, 8),
                            ),
                            BoxShadow(
                              color: Color(0xFFFFFFFF),
                              spreadRadius: 0,
                              blurRadius: 16,
                              offset: Offset(-8, -8),
                            )
                          ]
                      ),
//Report Suspicious Button
                      child: ElevatedButton(
                          onPressed: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const reportSuspicious()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFFF1F5F9), // Background color
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(height: 20),
                              Icon(
                                Icons.document_scanner,
                                size: 60,
                                color: Color(0xFF2D82B5).withOpacity(0.7),
                              ),
                              SizedBox(height: 5),
                              Text(
                                  'Suspicious Report',
                                  //textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontFamily: 'Inter',
                                      color: Color(0xFF015C92),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16)
                              ),
                            ],
                          )),
                    )
                  ]
              ),
              SizedBox(height: 20),
              SizedBox(
                height:150, //height of button
                width:320,
//Emergency Button
                child: ElevatedButton(
                    onPressed: (){
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => Dialog(
                          backgroundColor: Colors.transparent,
                          child: Container(
                            height: 400,
                            width: 370,
                            child: Row(
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    height:380,
                                    width:160,
                                    child: ElevatedButton(
                                        onPressed: () {
                                          showDialog<String>(
                                              context: context,
                                              builder: (BuildContext context) => Dialog(
                                                backgroundColor: Colors.transparent,
                                                child: Container(
                                                  height: 400,
                                                  width: 370,
                                                  child: Column(
                                                    children: [
                                                      SizedBox(
                                                        height:90,
                                                        width:370,
                                                        child: ElevatedButton.icon(
                                                            onPressed: ()async{
                                                              FlutterPhoneDirectCaller.callNumber("0356332222");
                                                            },
                                                            style: ElevatedButton.styleFrom(
                                                              primary: Colors.lightBlue[50], // Background color
                                                            ),
                                                            icon: Icon(Icons.local_police,
                                                              size: 30,
                                                              color: Color(0xFF015C92),),
                                                            label: Text('Police Station',
                                                                style: TextStyle(
                                                                    fontFamily: 'Inter',
                                                                    color: Color(0xFF015C92),
                                                                    fontWeight: FontWeight.w600,
                                                                    fontSize: 18)
                                                            )),
                                                      ),
                                                      SizedBox(height: 10),
                                                      SizedBox(
                                                        height:90,
                                                        width:370,
                                                        child: ElevatedButton.icon(
                                                            onPressed: ()async{
                                                              FlutterPhoneDirectCaller.callNumber("3333");
                                                            },
                                                            style: ElevatedButton.styleFrom(
                                                              primary: Colors.lightBlue[50], // Background color
                                                            ),
                                                            icon: Icon(Icons.fire_truck_rounded,
                                                              size: 30,
                                                              color: Color(0xFF015C92),),
                                                            label: Text('Fire and Rescue',
                                                                style: TextStyle(
                                                                    fontFamily: 'Inter',
                                                                    color: Color(0xFF015C92),
                                                                    fontWeight: FontWeight.w600,
                                                                    fontSize: 18)
                                                            )),
                                                      ),
                                                      SizedBox(height: 10),
                                                      SizedBox(
                                                        height:90,
                                                        width:370,
                                                        child: ElevatedButton.icon(
                                                            onPressed: ()async{
                                                              FlutterPhoneDirectCaller.callNumber("3333");
                                                            },
                                                            style: ElevatedButton.styleFrom(
                                                              primary: Colors.lightBlue[50], // Background color
                                                            ),
                                                            icon: Icon(Icons.local_hospital,
                                                              size: 30,
                                                              color: Color(0xFF015C92),),
                                                            label: Text('Ambulance',
                                                                style: TextStyle(
                                                                    fontFamily: 'Inter',
                                                                    color: Color(0xFF015C92),
                                                                    fontWeight: FontWeight.w600,
                                                                    fontSize: 18)
                                                            )),
                                                      ),
                                                      SizedBox(height: 10),
                                                      SizedBox(
                                                        height:90,
                                                        width:370,
                                                        child: ElevatedButton.icon(
                                                            onPressed: ()async{
                                                              FlutterPhoneDirectCaller.callNumber("3333");
                                                            },
                                                            style: ElevatedButton.styleFrom(
                                                              primary: Colors.lightBlue[50], // Background color
                                                            ),
                                                            icon: Icon(Icons.groups,
                                                              size: 30,
                                                              color: Color(0xFF015C92),),
                                                            label: Text('Neighbourhood Association',
                                                                style: TextStyle(
                                                                    fontFamily: 'Inter',
                                                                    color: Color(0xFF015C92),
                                                                    fontWeight: FontWeight.w600,
                                                                    fontSize: 18)
                                                            )),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ));
                                        },
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.lightBlue[50], // Background color
                                        ),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Icon(Icons.call,
                                              size: 90,
                                              color: Color(0xFF53A7DB),),
                                            Text("Call",
                                                style: TextStyle(
                                                    fontFamily: 'Inter',
                                                    color: Color(0xFF015C92),
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 32)
                                            ),
                                          ],
                                        )
                                    ),
                                  ),
                                ),
                                SizedBox(width:20),
                                Expanded(
                                  child: SizedBox(
                                    height:380,
                                    width:160,
                                    child: ElevatedButton(
                                        onPressed: () {
                                          showDialog<String>(
                                              context: context,
                                              builder: (BuildContext context) => Dialog(
                                                  backgroundColor: Colors.transparent,
                                                  child: Container(
                                                    padding: EdgeInsets.all(20.0),
                                                    height: 350,
                                                    width: 370,
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(10),
                                                        color: Color(0xFFFF0000)),
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Icon(
                                                          Icons.add_alert,
                                                          size: 70,
                                                          color: Colors.white,
                                                        ),
                                                        SizedBox(height: 10),
                                                        Text(
                                                            'An aler has sent your nearest police station and your guard patrol association !! \n \n'
                                                                'Please stay CALM !!',
                                                            textAlign: TextAlign.center,
                                                            style: TextStyle(
                                                                fontFamily: 'Inter',
                                                                color: Colors.white,
                                                                fontWeight: FontWeight.w600,
                                                                fontSize: 20))
                                                      ],
                                                    ),
                                                  ))
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.red[50], // Background color
                                        ),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Icon(Icons.add_alert,
                                              size: 90,
                                              color: Color(0xFFFF0000),),
                                            Text("Alert",
                                                style: TextStyle(
                                                    fontFamily: 'Inter',
                                                    color: Color(0xFFFF1C1C),
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 32)
                                            ),
                                          ],
                                        )
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFFFF1C1C), // Background color
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        Icon(
                          Icons.add_alert,
                          size: 70,
                        ),
                        SizedBox(height: 10),
                        Text(
                            'Emergency Button',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'Inter',
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 30)
                        ),
                      ],
                    )),
              ),
              SizedBox(height: 20),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height:135, //height of button
                      width:150,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xFFC9D9E8),
                              spreadRadius: 0,
                              blurRadius: 16,
                              offset: Offset(8, 8),
                            ),
                            BoxShadow(
                              color: Color(0xFFFFFFFF),
                              spreadRadius: 0,
                              blurRadius: 16,
                              offset: Offset(-8, -8),
                            )
                          ]
                      ),
//Incidence Report Button
                      child: ElevatedButton(
                          onPressed: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const IncidentReport()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFFF1F5F9), // Background color
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(height: 20),
                              Icon(
                                Icons.report,
                                size: 60,
                                color: Color(0xFF2D82B5).withOpacity(0.7),
                              ),
                              SizedBox(height: 5),
                              Text(
                                  'Incidence Report',
                                  style: TextStyle(
                                      fontFamily: 'Inter',
                                      color: Color(0xFF015C92),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16)
                              ),
                            ],
                          )),
                    ),
                    SizedBox(width: 20),
                    Container(
                      height:135, //height of button
                      width:150,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xFFC9D9E8),
                              spreadRadius: 0,
                              blurRadius: 16,
                              offset: Offset(8, 8),
                            ),
                            BoxShadow(
                              color: Color(0xFFFFFFFF),
                              spreadRadius: 0,
                              blurRadius: 16,
                              offset: Offset(-8, -8),
                            )
                          ]
                      ),
//House Status Button
                      child: ElevatedButton(
                          onPressed: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const HomePatrol()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFFF1F5F9), // Background color
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(height: 20),
                              Icon(
                                Icons.house,
                                size: 60,
                                color: Color(0xFF2D82B5).withOpacity(0.7),
                              ),
                              SizedBox(height: 5),
                              Text(
                                  'House Status',
                                  //textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontFamily: 'Inter',
                                      color: Color(0xFF015C92),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16)
                              ),
                            ],
                          )),
                    )
                  ]
              ),
              SizedBox(height: 20),
//Security Tips
              Container(
                height:120, //height of button
                width:320,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFFC9D9E8),
                        spreadRadius: 0,
                        blurRadius: 16,
                        offset: Offset(8, 8),
                      ),
                      BoxShadow(
                        color: Color(0xFFFFFFFF),
                        spreadRadius: 0,
                        blurRadius: 16,
                        offset: Offset(-8, -8),
                      )
                    ]
                ),
                child: ElevatedButton(
                    onPressed: (){},
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFFF1F5F9), // Background color
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                                Icons.lightbulb_outline,
                                size: 25,
                                color: Color(0xFF2D82B5).withOpacity(0.7)),
                            Text(
                                'Daily Security Tips',
                                style: TextStyle(
                                    fontFamily: 'Inter',
                                    color: Color(0xFF015C92),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16)
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Text(
                            'Make friends with neighbours',
                            style: TextStyle(
                                fontFamily: 'Inter',
                                color: Color(0xFF2D82B5),
                                fontWeight: FontWeight.w600,
                                fontSize: 14)
                        ),
                        SizedBox(height: 5),
                        Text(
                            'Offer yourself as a resource in case of emergencies or help needed on their end; some neighbors might reciprocate the offer.',
                            style: TextStyle(
                                fontFamily: 'Inter',
                                color: Color(0xFF2D82B5),
                                fontWeight: FontWeight.w600,
                                fontSize: 11)
                        ),
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


