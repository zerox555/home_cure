import 'package:flutter/material.dart';

class PatrolRoute{
  String routeName;
  List<Map<String,dynamic>> patrolPointsList;

  PatrolRoute(this.routeName,this.patrolPointsList);

  Map<String,dynamic> toMap(){
    return {
      'routeName' : this.routeName,
      'patrolPoints' : this.patrolPointsList
    };
  }
}