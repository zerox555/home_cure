import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:home_cure/services/database.dart';
import 'package:home_cure/services/storage.dart';
import 'package:readmore/readmore.dart';

import '../../models/incidence_report.dart';
import 'package:intl/intl.dart';

import '../../services/resources.dart';

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
      body: Container(
                margin: EdgeInsets.all(30.0),
                child: SingleChildScrollView(
                  physics: ScrollPhysics(),
                  child: Column(
                    children: [
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: Resources.incidenceReportList.length,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            String _dayOfYear = DateFormat('yyyy-MM-dd')
                                .format(Resources.incidenceReportList[index].timeOfOccurance);
                            String _timeOfDay = DateFormat('HH:mm:ss')
                                .format(Resources.incidenceReportList[index].timeOfOccurance);
                            int severity = Resources.incidenceReportList[index].severity;
                            var boxColor;
                            switch (severity) {
                              case 0:
                                boxColor = Colors.green[400];
                                break;
                              case 1:
                                boxColor = Colors.orange[400];
                                break;
                              case 2:
                                boxColor = Colors.red[400];
                                break;
                            }

                            return Column(children: [
                              Container(
                                padding: EdgeInsets.all(20.0),

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
                                        Flexible(
                                          child: Text(
                                              Resources.incidenceReportList[index].incidenceTitle,
                                              //can replace with $reportTitle
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontFamily: 'Inter',
                                                  color: Color(0xFFFFFFFF),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 24)),
                                        ),
                                        SizedBox(width: 50),
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
                                        'Reported By:\n${Resources.incidenceReportList[index].reporterName}\n${Resources.incidenceReportList[index].incidenceLocation}',
                                        //can replace with $reportedBy
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontFamily: 'Inter',
                                            color: Color(0xFFFFFFFF),
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14)),
                                    SizedBox(height: 5),
                                    //can replace with $textDescription
                                    ReadMoreText(
                                      Resources.incidenceReportList[index].incidenceDesc,
                                      trimLines: 2,
                                      textAlign: TextAlign.left,
                                      trimMode: TrimMode.Line,
                                      trimCollapsedText: 'Show more',
                                      style: TextStyle(
                                          fontFamily: 'Inter',
                                          color: Color(0xFFFFFFFF),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14),
                                      trimExpandedText: 'Show less',
                                      moreStyle: TextStyle(
                                          fontFamily: 'Inter',
                                          color: Color(0xFFFFFFFF),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                    ),
                                    SizedBox(height: 20),
                                    Image.asset(
                                        Resources.incidenceReportList[index].imageUrl!,
                                      height:130,width:300
                                    ),

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
                )),
    );

  }
}
