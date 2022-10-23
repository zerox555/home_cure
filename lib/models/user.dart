import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:home_cure/models/vehicle.dart';

class AppUser{
  final String? firebaseUId;
  String? name;
  int? age;
  String? gender;
  String? email;
  String? phoneNo;
  String? address;
  List<Map>? emergencyContacts;
  List<Map>? registeredVehicles;
  //registeredVehicles

  AppUser(this.firebaseUId);

  Map<String, dynamic> toFirestore() {
    return {
      if (name != null) "appUserName": name,
      if (age != null) "age": age,
      if (email != null) "email": email,
      if (phoneNo != null) "phoneNo": phoneNo,
      if (gender != null) "gender": gender,
      if (address != null) "address": address,
      if (emergencyContacts != null) "emergencyContacts" : emergencyContacts,
      if (registeredVehicles != null) "registeredVehicles": registeredVehicles,
    };
  }

  factory AppUser.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    AppUser appUser = AppUser('');
    appUser.name= data?['appUserName'];
    appUser.age= data?['age'];
    appUser.email= data?['email'];
    appUser.phoneNo= data?['phoneNo'];
    appUser.address = data?['address'];
    appUser.gender= data?['gender'];
    appUser.emergencyContacts= data?['emergencyContacts'] is Iterable ? List.from(data?['emergencyContacts']) : null;
    appUser.registeredVehicles= data?['registeredVehicles'] is Iterable ? List.from(data?['registeredVehicles']) : null;

    return appUser;
  }
}