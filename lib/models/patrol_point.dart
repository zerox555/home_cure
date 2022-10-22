import 'package:flutter/material.dart';

class PatrolPoint{
  bool isPassed;
  String address;
  Map<String, dynamic> cordsOnMap;

  PatrolPoint(this.isPassed,this.address,this.cordsOnMap);

  Map<String,dynamic> toMap(){
    return {
      'isPassed': this.isPassed,
      'address' : this.address,
      'cordsOnMap': {
        'lat': this.cordsOnMap['lat'],
        'lng': this.cordsOnMap['lng'],
      }
    };
  }
}