import 'package:flutter/material.dart';
import 'package:home_cure/models/vehicle.dart';

class EntryEntity{

  final DateTime timeOfReg;
  final DateTime timeOfExpiry;
  final Vehicle vehicle;

  EntryEntity(this.timeOfReg, this.timeOfExpiry, this.vehicle);

}