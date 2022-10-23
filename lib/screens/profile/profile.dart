import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_cure/screens/profile/app_settings.dart';
import 'package:home_cure/screens/profile/emergency_contact.dart';
import 'package:home_cure/screens/profile/faq.dart';
import 'package:home_cure/screens/profile/profile_setting.dart';
import 'package:home_cure/screens/profile/registered_vehicles.dart';
import 'package:home_cure/screens/profile/security_tips.dart';
import 'package:home_cure/services/database.dart';
import '../../services/auth.dart';

import '../../models/security_tips.dart';
import '../../models/user.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  DatabaseService getDatabaseService() {
    String? _uId = FirebaseAuth.instance.currentUser?.uid;
    DatabaseService _dbService = DatabaseService(_uId ?? '');
    return _dbService;
  }
  updateParent(){
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getDatabaseService().getProfile(),
        builder: (BuildContext context, AsyncSnapshot<AppUser?> snapshot) {
          List<Widget> children;
          if (snapshot.hasData) {
            children = <Widget>[
              Center(
                  child:Container(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // ProfileSettings(),
                        Container(
                          padding: EdgeInsets.all(20.0),
                          width: 330,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xFFEFF7FF),
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
                              ]),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.account_circle,
                                      size: 40,
                                      color: Color(0xFF015C92)),
                                  SizedBox(width: 5),
                                  Text("Profile",
                                      style: TextStyle(
                                          fontFamily: 'Inter',
                                          color: Color(0xFF015C92),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20)
                                  ),
                                  SizedBox(width: 130),
                                  IconButton(
                                      onPressed: (){
                                        Navigator.push(context,MaterialPageRoute(builder: (context) =>ProfileSettings(updateParent)));
                                      },
                                      icon: Icon(Icons.edit,
                                          size: 25,
                                          color: Color(0xFF015C92)))
                                ],
                              ),
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  Text("Name: ",
                                      style: TextStyle(
                                          fontFamily: 'Inter',
                                          color: Color(0xFF015C92),
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16)),
                                  Text("${snapshot.data!.name.toString()}",
                                      style: TextStyle(
                                          fontFamily: 'Inter',
                                          color: Color(0xFF015C92),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16)),
                                ],
                              ),
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  Text("Age: ",
                                      style: TextStyle(
                                          fontFamily: 'Inter',
                                          color: Color(0xFF015C92),
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16)),
                                  Text("${snapshot.data!.age.toString()} ",
                                      style: TextStyle(
                                          fontFamily: 'Inter',
                                          color: Color(0xFF015C92),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16)),
                                ],
                              ),
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  Text("Gender: " ,
                                      style: TextStyle(
                                          fontFamily: 'Inter',
                                          color: Color(0xFF015C92),
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16)),
                                  Text(
                                      "${snapshot.data!.gender.toString()} ",
                                      style: TextStyle(
                                          fontFamily: 'Inter',
                                          color: Color(0xFF015C92),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16)),
                                ],
                              ),
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  Text("Email: ",
                                      style: TextStyle(
                                          fontFamily: 'Inter',
                                          color: Color(0xFF015C92),
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16)),
                                  Text(
                                      "${snapshot.data!.email.toString()} ",
                                      style: TextStyle(
                                          fontFamily: 'Inter',
                                          color: Color(0xFF015C92),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16)),
                                ],
                              ),
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  Text("Phone No: ",
                                      style: TextStyle(
                                          fontFamily: 'Inter',
                                          color: Color(0xFF015C92),
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16)),
                                  Text(
                                      "${snapshot.data!.phoneNo.toString()} ",
                                      style: TextStyle(
                                          fontFamily: 'Inter',
                                          color: Color(0xFF015C92),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16)),
                                ],
                              ),
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  Text("Address: ",
                                      style: TextStyle(
                                          fontFamily: 'Inter',
                                          color: Color(0xFF015C92),
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16)),
                                  Text(
                                      "${snapshot.data!.address.toString()} ",
                                      style: TextStyle(
                                          fontFamily: 'Inter',
                                          color: Color(0xFF015C92),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16)),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        SizedBox(
                          width: 330,
                          height: 50,
                          child: ElevatedButton(
                              onPressed: (){
                                Navigator.push(context,MaterialPageRoute(builder: (context) => RegisteredVehicles()));
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Color(0xFFEFF7FF), // Background color
                              ),
                              child:Row(
                                children: [
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: Icon(Icons.drive_eta_rounded ,
                                        size: 30,
                                        color: Color(0xFF015C92),)
                                  ),
                                  Container(
                                      margin: const EdgeInsets.only( left: 10.0 ),
                                      child: Text(
                                        "Registered Vehicle",
                                        style: TextStyle(
                                            fontFamily: 'Inter',
                                            color: Color(0xFF015C92),
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16),
                                      )
                                  )
                                ],
                              )),
                        ),
                        SizedBox(height: 20),
                        SizedBox(
                          width: 330,
                          height: 50,
                          child: ElevatedButton(
                              onPressed: (){
                                Navigator.push(context,MaterialPageRoute(builder: (context) => SecurityTips()));
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Color(0xFFEFF7FF), // Background color
                              ),
                              child:Row(
                                children: [
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: Icon(Icons.security ,
                                        size: 30,
                                        color: Color(0xFF015C92),)
                                  ),
                                  Container(
                                      margin: const EdgeInsets.only( left: 10.0 ),
                                      child: Text(
                                        "Security Tips",
                                        style: TextStyle(
                                            fontFamily: 'Inter',
                                            color: Color(0xFF015C92),
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16),
                                      )
                                  )
                                ],
                              )),
                        ),
                        SizedBox(height: 20),
                        SizedBox(
                          width: 330,
                          height: 50,
                          child: ElevatedButton(
                              onPressed: (){
                                Navigator.push(context,MaterialPageRoute(builder: (context) => FAQ()));
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Color(0xFFEFF7FF), // Background color
                              ),
                              child:Row(
                                children: [
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: Icon(Icons.help ,
                                        size: 30,
                                        color: Color(0xFF015C92),)
                                  ),
                                  Container(
                                      margin: const EdgeInsets.only( left: 10.0 ),
                                      child: Text(
                                        "FAQ",
                                        style: TextStyle(
                                            fontFamily: 'Inter',
                                            color: Color(0xFF015C92),
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16),
                                      )
                                  )
                                ],
                              )),
                        ),
                        SizedBox(height: 20),
                        SizedBox(
                          width: 330,
                          height: 50,
                          child: ElevatedButton(
                              onPressed: (){
                                Navigator.push(context,MaterialPageRoute(builder: (context) => AppSettings()));
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Color(0xFFEFF7FF), // Background color
                              ),
                              child:Row(
                                children: [
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: Icon(Icons.settings ,
                                        size: 30,
                                        color: Color(0xFF015C92),)
                                  ),
                                  Container(
                                      margin: const EdgeInsets.only( left: 10.0 ),
                                      child: Text(
                                        "Settings",
                                        style: TextStyle(
                                            fontFamily: 'Inter',
                                            color: Color(0xFF015C92),
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16),
                                      )
                                  )
                                ],
                              )),
                        ),
                        SizedBox(height: 20),
                        SizedBox(
                          width: 330,
                          height: 50,
                          child: ElevatedButton(
                              onPressed: (){
                                Navigator.push(context,MaterialPageRoute(builder: (context) => EmergencyContacts()));
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Color(0xFFEFF7FF), // Background color
                              ),
                              child:Row(
                                children: [
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: Icon(Icons.contact_phone_rounded ,
                                        size: 30,
                                        color: Color(0xFF015C92),)
                                  ),
                                  Container(
                                      margin: const EdgeInsets.only( left: 10.0 ),
                                      child: Text(
                                        "Emergency Contacts",
                                        style: TextStyle(
                                            fontFamily: 'Inter',
                                            color: Color(0xFF015C92),
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16),
                                      )
                                  )
                                ],
                              )),
                        ),
                        SizedBox(height: 20),
                        SizedBox(
                          width: 330,
                          height: 50,
                          child: ElevatedButton(
                              onPressed: ()
                                {
                                  AuthService _auth = AuthService();
                                  _auth.signOut();
                                },
                              style: ElevatedButton.styleFrom(
                                primary: Color(0xFFEFF7FF), // Background color
                              ),
                              child:Row(
                                children: [
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: Icon(Icons.logout ,
                                        size: 30,
                                        color: Color(0xFF015C92),)
                                  ),
                                  Container(
                                      margin: const EdgeInsets.only( left: 10.0 ),
                                      child: Text(
                                        "Log Out",
                                        style: TextStyle(
                                            fontFamily: 'Inter',
                                            color: Color(0xFF015C92),
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16),
                                      )
                                  )
                                ],
                              )),
                        )

                      ],
                    ),
                  )
              )];
          } else if (snapshot.hasError) {
            children = <Widget>[
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('Error: ${snapshot.error}'),
              ),
            ];
          } else {
            children = const <Widget>[
              SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text('Awaiting result...'),
              ),
            ];
          }
          return Stack(children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: children,
            )
          ]);
        }

      //one card
      // 5 buttons
    );
  }
}
