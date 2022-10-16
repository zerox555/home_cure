import 'package:flutter/material.dart';
import 'package:home_cure/models/vehicle.dart';

class SuspiciousEventReport{

  final Vehicle vehicle;
  final String address;
  final String description;

  SuspiciousEventReport(this.vehicle, this.address, this.description);

}