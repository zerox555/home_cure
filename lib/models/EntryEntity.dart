import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:home_cure/models/vehicle.dart';

class EntryEntity {
  String? userId;
  final DateTime timeOfReg;
  final DateTime timeOfEntryStart;
  final DateTime timeOfEntryEnd;
  final Map<String, dynamic> vehicle;
  final String personName;
  final int reasonOfVisit;
  //reason of visit
  //0 -> rider
  //1 -> visitor
  //2 -> maintenance

  EntryEntity(this.timeOfReg, this.timeOfEntryStart, this.timeOfEntryEnd,
      this.vehicle, this.personName, this.reasonOfVisit);


}
