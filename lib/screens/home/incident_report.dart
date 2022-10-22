import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:home_cure/services/database.dart';
import 'package:home_cure/services/storage.dart';

import '../../models/incidence_report.dart';
import 'package:intl/intl.dart';

class IncidentReport extends StatefulWidget {
  const IncidentReport({Key? key}) : super(key: key);

  @override
  State<IncidentReport> createState() => _IncidentReportState();
}

class _IncidentReportState extends State<IncidentReport> {
  DatabaseService _dbService =
      DatabaseService(FirebaseAuth.instance.currentUser!.uid);
  Storage _storageService = Storage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Incidence Report",
            style: TextStyle(
                fontFamily: 'Inter',
                color: Colors.lightBlue[900],
                fontWeight: FontWeight.bold,
                fontSize: 22)),
        centerTitle: true,
        backgroundColor: Colors.lightBlueAccent[100],
      ),
      body: FutureBuilder(
        future: _dbService.getIncidenceReport(),
        builder: (BuildContext context,
            AsyncSnapshot<List<IncidenceReport>> snapshot) {
          if (snapshot.hasData) {
            return Container(
                margin: EdgeInsets.all(30.0),
                child: SingleChildScrollView(
                  physics: ScrollPhysics(),
                  child: Column(
                    children: [
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            String _dayOfYear = DateFormat('yyyy-MM-dd')
                                .format(snapshot.data![index].timeOfOccurance);
                            String _timeOfDay = DateFormat('HH:mm:ss')
                                .format(snapshot.data![index].timeOfOccurance);
                            int severity = snapshot.data![index].severity;
                            var boxColor;
                            switch (severity){
                              case 0:
                                boxColor = Color(0xFFC2FCB2);
                                break;
                              case 1:
                                boxColor = Color(0xE7FFA06D);
                                break;
                              case 2:
                                boxColor = Color(0xFFCE697D);
                                break;
                            }

                            return Column(children: [
                              Container(
                                padding: EdgeInsets.all(20.0),
                                height: 350,
                                width: 370,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: boxColor),
                                //Depend on the incidence level (or else we put this action at last first)
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    //Report Title and Time
                                    Row(
                                      children: [
                                        Text(
                                            snapshot
                                                .data![index].incidenceTitle,
                                            //can replace with $reportTitle
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                fontFamily: 'Inter',
                                                color: Color(0xFFFFFFFF),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 24)),
                                        SizedBox(width: 100),
                                        Text('${_dayOfYear}\n ${_timeOfDay}',
                                            //can replace with $time and $date
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                                fontFamily: 'Inter',
                                                color: Color(0xFFFFFFFF),
                                                fontWeight: FontWeight.w700,
                                                fontSize: 14))
                                      ],
                                    ),
                                    //Reported By
                                    SizedBox(height: 5),
                                    Text(
                                        'Reported By:\n${snapshot.data![index].reporterName}\n${snapshot.data![index].incidenceLocation}',
                                        //can replace with $reportedBy
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontFamily: 'Inter',
                                            color: Color(0xFFFFFFFF),
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14)),
                                    SizedBox(height: 5),
                                    //can replace with $textDescription
                                    Text(
                                      snapshot.data![index].incidenceDesc,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontFamily: 'Inter',
                                          color: Color(0xFFFFFFFF),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14),
                                    ),
                                    SizedBox(height: 10),
                                    FutureBuilder(
                                        future: _storageService.downloadUrl(
                                            snapshot.data![index].imageUrl!),
                                        builder: (BuildContext context,
                                            AsyncSnapshot<String> snapshot) {
                                          if (snapshot.hasData) {
                                            return ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              child: Image.network(
                                                snapshot.data!,
                                                height: 130,
                                                width: 300,
                                                fit: BoxFit.fill,
                                              ),
                                            );
                                          } else {
                                            return Container(
                                                child: Text(
                                                    "Image cannot be loaded"));
                                          }
                                        }),

                                    //Description
                                    //Image
                                  ],
                                ),
                              ),
                              SizedBox(height: 20)
                            ]);
                          }),
                    ],
                  ),
                ));
            return Container(child: Text(snapshot.data![0].incidenceTitle));
          } else {
            return Container(
              child: Text("Hvanet loaded"),
            );
          }
        },
      ),
    );
  }
}
