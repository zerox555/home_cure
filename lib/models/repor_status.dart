import 'package:flutter/material.dart' ;

class ReportStatus{
  String reportId;
  String reportTitle;
  static const List<String> reportDesc =["You have successfully submitted your report!, please be patient as we look into the submission.","We have started looking into your submission, please be patient.","We have finished looking into your submission,","There was a problem with the resolution of you submission, please try again"];
  String? addDesc;
  int status;
  //status
  //0 -> havent started
  //1 -> in progress
  //2 -> done
  //3 -> run into problems

  ReportStatus(this.reportId,this.reportTitle,this.status,this.addDesc);

  String getDesc(){
    String returnText = '';
    switch(status){
      case 0: returnText = reportDesc[0];
      break;
      case 1: returnText = reportDesc[1];
      break;
      case 2: returnText = reportDesc[2];
      break;
      case 3: returnText = reportDesc[3];
      break;
    }
    return returnText;
  }

  String getStatusText(){
    String returnText = '';
    switch(status){
      case 0: returnText = "Pending";
      break;
      case 1: returnText = "In Progress";
      break;
      case 2: returnText = "Done";
      break;
      case 3: returnText = "Run into problem";
      break;
    }
    return returnText;
  }

}