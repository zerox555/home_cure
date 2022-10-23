import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:home_cure/models/incidence_report.dart';
import 'package:home_cure/services/database.dart';
import 'package:home_cure/services/resources.dart';

import '../../models/patrol_route.dart';
import '../../services/auth.dart';

class Message extends StatefulWidget {
  const Message({Key? key}) : super(key: key);

  @override
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Container(
        margin: EdgeInsets.fromLTRB(5, 50, 5, 0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: Resources.reportStatusList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      padding: EdgeInsets.all(20.0),
                      margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                      width: 370,

                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xFFE0F0FF),
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
                          ]), //Depend on the incidence level (or else we put this action at last first)
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                // backgroundImage: AssetImage('assets/jesse.jpg'),
                                radius: 18.0,
                              ),
                              SizedBox(width: 12),
                              Text(
                                  'Resident Association', //can replace with $reportTitle
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontFamily: 'Inter',
                                      color: Color(0xFF015C92),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16))
                            ],
                          ),
                          SizedBox(height: 10),
                          Text(
                              "${Resources.reportStatusList[index].getDesc()} ${Resources.reportStatusList[index].addDesc}", //can replace with $reportTitle
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontFamily: 'Inter',
                                  color: Color(0xFF015C92),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14)),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Text(
                                  'Report Title: ', //can replace with $reportTitle
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontFamily: 'Inter',
                                      color: Color(0xFF015C92),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14)),
                              Flexible(
                                child: Text(Resources.reportStatusList[index].reportTitle, //can replace with $reportTitle
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontFamily: 'Inter',
                                        color: Color(0xFF015C92),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14)),
                              )
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Text(
                                  'Report ID: ', //can replace with $reportTitle
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontFamily: 'Inter',
                                      color: Color(0xFF015C92),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14)),
                              Text(Resources.reportStatusList[index].reportId, //can replace with $reportTitle
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontFamily: 'Inter',
                                      color: Color(0xFF015C92),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14))
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Text('Status: ', //can replace with $reportTitle
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontFamily: 'Inter',
                                      color: Color(0xFF015C92),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14)),
                              Text(Resources.reportStatusList[index].getStatusText(), //can replace with $reportTitle
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontFamily: 'Inter',
                                      color: Color(0xFF015C92),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14))
                            ],
                          ),
                        ],
                      ),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
