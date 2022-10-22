import 'package:flutter/material.dart';
import 'package:home_cure/models/vehicle.dart';

class SuspiciousEventReport{

  final Map<String,dynamic> vehicle;
  final String address;
  final String description;
  String? imageUrl;

  SuspiciousEventReport(this.vehicle, this.address, this.description);

}