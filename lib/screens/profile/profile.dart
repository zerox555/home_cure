import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_cure/screens/profile/app_settings.dart';
import 'package:home_cure/screens/profile/emergency_contact.dart';
import 'package:home_cure/screens/profile/faq.dart';
import 'package:home_cure/screens/profile/profile_setting.dart';
import 'package:home_cure/screens/profile/registered_vehicles.dart';
import 'package:home_cure/screens/profile/security_tips.dart';
import 'package:home_cure/services/database.dart';

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
                child: Column(
                  children: [
                    // ProfileSettings(),
                    Padding(padding: EdgeInsets.all(20)),
                    Card(
                      child: InkWell(
                        splashColor: Colors.blue.withAlpha(30),
                        onTap: () {
                          Navigator.push(context,MaterialPageRoute(builder: (context) =>ProfileSettings()));
                        },
                        child: SizedBox(
                            width: 300,
                            child: Column(
                              children: [
                                Text("PROFILE"),
                                Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        10.0, 0.0, 0.0, 0.0)),
                                Text(
                                    "Name: ${snapshot.data!.name.toString()} "),
                                Text("Age: ${snapshot.data!.age.toString()} "),
                                Text(
                                    "Gender: ${snapshot.data!.gender.toString()} "),
                                Text(
                                    "Email: ${snapshot.data!.email.toString()} "),
                                Text(
                                    "PhoneNo: ${snapshot.data!.phoneNo.toString()} "),

                                // Text("Registered Vehicles: ${snapshot.data!.registeredVehicles.toString()} "),
                              ],
                            )),
                      ),
                    ),
                    Card(
                      child: InkWell(
                        splashColor: Colors.blue.withAlpha(30),
                        onTap: () {
                          Navigator.push(context,MaterialPageRoute(builder: (context) => RegisteredVehicles()));
                        },
                        child: SizedBox(
                            width: 300,
                            height: 50,
                            child: Text("Registered Vehicles")),
                      ),
                    ),
                    Card(
                      child: InkWell(
                        splashColor: Colors.blue.withAlpha(30),
                        onTap: () {
                          Navigator.push(context,MaterialPageRoute(builder: (context) => SecurityTips()));
                        },
                        child: SizedBox(
                            width: 300,
                            height: 50,
                            child: Text("Security Tips")),
                      ),
                    ),
                    Card(
                      child: InkWell(
                        splashColor: Colors.blue.withAlpha(30),
                        onTap: () {
                          Navigator.push(context,MaterialPageRoute(builder: (context) => FAQ()));

                        },
                        child: SizedBox(
                            width: 300,
                            height: 50,
                            child: Text("FAQ")),
                      ),
                    ),
                    Card(
                      child: InkWell(
                        splashColor: Colors.blue.withAlpha(30),
                        onTap: () {
                          Navigator.push(context,MaterialPageRoute(builder: (context) => AppSettings()));

                        },
                        child: SizedBox(
                            width: 300,
                            height: 50,
                            child: Text("Settings")),
                      ),
                    ),
                    Card(
                      child: InkWell(
                        splashColor: Colors.blue.withAlpha(30),
                        onTap: () {
                          Navigator.push(context,MaterialPageRoute(builder: (context) => EmergencyContacts()));

                        },
                        child: SizedBox(
                            width: 300,
                            height: 50,
                            child: Text("Emergency Contacts")),
                      ),
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
