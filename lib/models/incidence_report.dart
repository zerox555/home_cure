import 'package:flutter/material.dart';

class IncidenceReport{

  String incidenceTitle;
  DateTime timeOfOccurance;
  String reporterName;
  String reporterUid;
  String incidenceDesc;
  String incidenceLocation;
  String? imageUrl;
  int severity;
  //severity rating
  //0 -> low risk
  //1 -> normal risk
  //2 -> high risk

  IncidenceReport(this.incidenceTitle,this.timeOfOccurance,this.reporterName,this.reporterUid,this.incidenceDesc,this.incidenceLocation,this.severity);

}