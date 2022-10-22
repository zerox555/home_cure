import 'package:flutter/material.dart';

class Vehicle {
  String carPlate;
 DateTime? timeOfReg;
  //vehicle type:
  //0 -> car
  //1 -> Motor
  //2 -> Van
  //3 -> lorry
  final int vehicleType;

  Vehicle(this.carPlate, this.timeOfReg, this.vehicleType);

  Map<String, dynamic> toMap() {
    return {
      "carPlate": carPlate,
      "timeOfRef": timeOfReg,
      "vehicleType": vehicleType
    };
  }

  //to store in firebase
  static List<Map> ConvertVehiclesToMap(List<Vehicle> regVehicles) {
    List<Map> vehicles = [];
    regVehicles.forEach((element) {
      Map vehicle = element.toMap();
      vehicles.add(vehicle);
    });
    return vehicles;
  }
}
