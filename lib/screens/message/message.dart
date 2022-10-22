import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:home_cure/models/incidence_report.dart';
import 'package:home_cure/services/database.dart';
import 'package:home_cure/services/resources.dart';

import '../../models/patrol_route.dart';
import '../../services/auth.dart';

class Message extends StatelessWidget {
  Message({Key? key}) : super(key: key);




  @override
  Widget build(BuildContext context) {

// no need of the file extension, the name will do fine.

    DatabaseService _dbService = DatabaseService(FirebaseAuth.instance.currentUser!.uid);
    IncidenceReport incidenceReport = (IncidenceReport("robbery", DateTime.now(), "laujingen", _dbService.uid, "Some robbers robbed me", "usj3/5b",2));
    incidenceReport.imageUrl = 'incidenceReports/images.png';
    // _dbService.addIncidenceReport(incidenceReport, _dbService.getSelectedCollection('incidenceReport'));

    // _dbService.addHousePatrolRoute(Resources.getPatrolRoute(), _dbService.getSelectedCollection("patrolRoute"));

    return FutureBuilder<PatrolRoute>(
        future: _dbService.getPatrolRoute(),
    builder: (BuildContext context,
    AsyncSnapshot<PatrolRoute> snapshotFutureDb) {
          if(snapshotFutureDb.hasData == true){
            return ElevatedButton(
                onPressed:()
            {
              AuthService _auth = AuthService();
              _auth.signOut();
              }, child: Text("Signout"));
            // return Center(child:Text(snapshotFutureDb.data!.patrolPointsList[0]['address']));
          }else{
            return Center(child:Text("No data"));

          }
    });
  }
}
