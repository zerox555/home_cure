import 'package:flutter/material.dart';
import 'package:home_cure/models/vehicle.dart';

class SuspiciousEventReport{

  static int currentId = 3;
  final Map<String,dynamic> vehicle;
  final String address;
  final String description;
  String? eventId;
  String? imageUrl;

  SuspiciousEventReport(this.vehicle, this.address, this.description){
    eventId = (currentId++).toString();
    print(currentId);
    print(eventId);
  }

}