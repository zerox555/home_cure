import 'package:flutter/material.dart';

class Vehicle{
  final String carPlate;
  final DateTime timeOfReg;
  //vehicle type:
  //0 -> car
  //1 -> Motor
  //2 -> Van
  //3 -> lorry
  final int vehicleType;

  Vehicle(this.carPlate, this.timeOfReg, this.vehicleType);


}