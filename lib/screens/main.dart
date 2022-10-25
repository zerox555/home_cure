
import 'package:flutter/material.dart';
import 'package:home_cure/screens/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';
import '../services/auth.dart';
import '../services/resources.dart';

Future <void> main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //initialize event list
  Resources.initializeCommunityEvents();
  Resources.initializeDiscussionPosts();
  // Resources.initializeVehiclePlates();
  // Resources.initializeEmergencyContacts();
  // Resources.initializeRegisteredVehicles();
  Resources.initializeReportStatus();
  Resources.initializeIncidenceReportList();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<AppUser?>.value(
      initialData: null,
      value: AuthService().getUserStream,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
