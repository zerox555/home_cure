import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_cure/models/EntryEntity.dart';
import 'package:home_cure/models/incidence_report.dart';
import 'package:home_cure/models/vehicle.dart';
import 'package:home_cure/services/database.dart';
import 'package:home_cure/services/resources.dart';

class EntryRegistration extends StatefulWidget {
  const EntryRegistration({Key? key}) : super(key: key);

  @override
  State<EntryRegistration> createState() => _EntryRegistrationState();
}

enum vehicleType { Car, Motor, Van, Lorry }

enum category { Rider, Visitor }

class _EntryRegistrationState extends State<EntryRegistration> {
  DatabaseService _dbService =
      DatabaseService(FirebaseAuth.instance.currentUser!.uid);

  //form values
  String _currentName = '';
  String _currentVehiclePlate = '';
  vehicleType? _vehicleType;
  category? _category;
  TimeOfDay timeFrom = TimeOfDay(hour: 10, minute: 30);
  TimeOfDay timeTo = TimeOfDay(hour: 12, minute: 30);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Rider / Visitor Registration",
            style: TextStyle(
                fontFamily: 'Inter',
                color: Colors.lightBlue[900],
                fontWeight: FontWeight.bold,
                fontSize: 22)),
        centerTitle: true,
        backgroundColor: Colors.lightBlueAccent[100],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          margin: EdgeInsets.all(30.0),
          child: Column(
            children: [
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
//Name
                    Text('Name: ',
                        style: TextStyle(
                            fontFamily: 'Inter',
                            color: Color(0xFF015C92),
                            fontWeight: FontWeight.w600,
                            fontSize: 16)),
                    SizedBox(height: 10),
                    Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.lightBlue[100],
                        borderRadius: new BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 15, right: 15, top: 5, bottom: 5),
                        child: TextFormField(
                          decoration: InputDecoration(border: InputBorder.none),
                          onChanged: (value) {
                            setState(() {
                              _currentName = value.toString();
                            });
                          },
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the name';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
//Vehicle Number Plate
                  Text('Vehicle Number Plate: ',
                      style: TextStyle(
                          fontFamily: 'Inter',
                          color: Color(0xFF015C92),
                          fontWeight: FontWeight.w600,
                          fontSize: 16)),
                  SizedBox(height: 10),
                  Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.lightBlue[100],
                      borderRadius: new BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
                      child: TextFormField(
                        decoration: InputDecoration(border: InputBorder.none),
                        onChanged: (value) {
                          setState(() {
                            _currentVehiclePlate = value.toString();
                          });
                        },
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the number plate';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ],
              )),
              SizedBox(height: 20),
              Container(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
//Vehicle Number Plate
                  Text('Vehicle Type: ',
                      style: TextStyle(
                          fontFamily: 'Inter',
                          color: Color(0xFF015C92),
                          fontWeight: FontWeight.w600,
                          fontSize: 16)),
                  SizedBox(height: 10),
//Vehicle Type
                  Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: RadioListTile<vehicleType>(
                                value: vehicleType.Car,
                                groupValue: _vehicleType,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                activeColor: Color(0xFF015C92),
                                title: Text(vehicleType.Car.name,
                                    style: TextStyle(
                                        fontFamily: 'Inter',
                                        color: Color(0xFF53A7D8),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16)),
                                tileColor: Colors.lightBlue[100],
                                dense: true,
                                onChanged: (val) {
                                  setState(() {
                                    _vehicleType = val;
                                  });
                                }),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: RadioListTile<vehicleType>(
                                contentPadding: EdgeInsets.all(0.0),
                                value: vehicleType.Motor,
                                groupValue: _vehicleType,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                activeColor: Color(0xFF015C92),
                                title: Text(vehicleType.Motor.name,
                                    style: TextStyle(
                                        fontFamily: 'Inter',
                                        color: Color(0xFF53A7D8),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16)),
                                tileColor: Colors.lightBlue[100],
                                dense: true,
                                onChanged: (val) {
                                  setState(() {
                                    _vehicleType = val;
                                  });
                                }),
                          )
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: RadioListTile<vehicleType>(
                                value: vehicleType.Van,
                                groupValue: _vehicleType,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                activeColor: Color(0xFF015C92),
                                title: Text(vehicleType.Van.name,
                                    style: TextStyle(
                                        fontFamily: 'Inter',
                                        color: Color(0xFF53A7D8),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16)),
                                tileColor: Colors.lightBlue[100],
                                dense: true,
                                onChanged: (val) {
                                  setState(() {
                                    _vehicleType = val;
                                  });
                                }),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: RadioListTile<vehicleType>(
                                contentPadding: EdgeInsets.all(0.0),
                                value: vehicleType.Lorry,
                                groupValue: _vehicleType,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                activeColor: Color(0xFF015C92),
                                title: Text(vehicleType.Lorry.name,
                                    style: TextStyle(
                                        fontFamily: 'Inter',
                                        color: Color(0xFF53A7D8),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16)),
                                tileColor: Colors.lightBlue[100],
                                dense: true,
                                onChanged: (val) {
                                  setState(() {
                                    _vehicleType = val;
                                  });
                                }),
                          )
                        ],
                      )
                    ],
                  )
                ],
              )),
              SizedBox(height: 20),
              Container(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
//Vehicle Number Plate
                  Text('Category: ',
                      style: TextStyle(
                          fontFamily: 'Inter',
                          color: Color(0xFF015C92),
                          fontWeight: FontWeight.w600,
                          fontSize: 16)),
                  SizedBox(height: 10),
                  Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: RadioListTile<category>(
                                value: category.Rider,
                                groupValue: _category,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                activeColor: Color(0xFF015C92),
                                title: Text(category.Rider.name,
                                    style: TextStyle(
                                        fontFamily: 'Inter',
                                        color: Color(0xFF53A7D8),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16)),
                                tileColor: Colors.lightBlue[100],
                                dense: true,
                                onChanged: (val) {
                                  setState(() {
                                    _category = val;
                                  });
                                }),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: RadioListTile<category>(
                                contentPadding: EdgeInsets.all(0.0),
                                value: category.Visitor,
                                groupValue: _category,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                activeColor: Color(0xFF015C92),
                                title: Text(category.Visitor.name,
                                    style: TextStyle(
                                        fontFamily: 'Inter',
                                        color: Color(0xFF53A7D8),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16)),
                                tileColor: Colors.lightBlue[100],
                                dense: true,
                                onChanged: (val) {
                                  setState(() {
                                    _category = val;
                                  });
                                }),
                          )
                        ],
                      ),
                    ],
                  )
                ],
              )),
              SizedBox(height: 20),
              Container(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
//Vehicle Number Plate
                  Text('Visiting Time Range: ',
                      style: TextStyle(
                          fontFamily: 'Inter',
                          color: Color(0xFF015C92),
                          fontWeight: FontWeight.w600,
                          fontSize: 16)),
                  SizedBox(height: 10),
                  Container(
                      child: Row(
                    children: [
                      Text('From: ',
                          style: TextStyle(
                              fontFamily: 'Inter',
                              color: Color(0xFF015C92),
                              fontWeight: FontWeight.w600,
                              fontSize: 16)),
                      SizedBox(width: 20),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.lightBlue[100], // Background color
                          ),
                          onPressed: () async {
                            TimeOfDay? newTime = await showTimePicker(
                                context: context, initialTime: timeFrom);
                            // if cancel is clicked
                            if (newTime == null) return;
                            // if ok is clicked
                            setState(() {
                              timeFrom = newTime;
                            });
                          },
                          child: Text('${timeFrom.hour} : ${timeFrom.minute}',
                              style: TextStyle(
                                  fontFamily: 'Inter',
                                  color: Color(0xFF53A7D8),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16))),
                      SizedBox(width: 30),
                      Text('To: ',
                          style: TextStyle(
                              fontFamily: 'Inter',
                              color: Color(0xFF015C92),
                              fontWeight: FontWeight.w600,
                              fontSize: 16)),
                      SizedBox(width: 20),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.lightBlue[100], // Background color
                          ),
                          onPressed: () async {
                            TimeOfDay? newTime = await showTimePicker(
                                context: context, initialTime: timeTo);
                            // if cancel is clicked
                            if (newTime == null) return;
                            // if ok is clicked
                            setState(() {
                              timeTo = newTime;
                            });
                          },
                          child: Text('${timeTo.hour} : ${timeTo.minute}',
                              style: TextStyle(
                                  fontFamily: 'Inter',
                                  color: Color(0xFF53A7D8),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16)))
                    ],
                  )),
                ],
              )),
              SizedBox(height: 30),
              Container(
                height: 60, //height of button
                width: 150,

//Rider/Visitor Button
                child: ElevatedButton(
                    onPressed: () {
                      //create vehicle object
                      int vehicleT = 0;
                      if (_vehicleType == vehicleType.Car) {
                        vehicleT = 0;
                      } else if (_vehicleType == vehicleType.Motor) {
                        vehicleT = 1;
                      } else if (_vehicleType == vehicleType.Van) {
                        vehicleT = 2;
                      } else {
                        vehicleT = 3;
                      }
                      Vehicle vehicle =
                          Vehicle(_currentVehiclePlate, DateTime.now(), vehicleT);
                      // _dbService.firstConfigurationEntryEntity(_dbService.getSelectedCollection("tempEntry"));
                      List<EntryEntity> entryEntityOld;
                      EntryEntity entryEntity;
                      //get back list of vehicle from firebase
                      // entryEntityOld.vehicle!.add(vehicle.toMap());
                      entryEntity = EntryEntity(
                          DateTime.now(),
                          DateTime(DateTime.now().year, DateTime.now().month,
                              DateTime.now().day, timeFrom.hour, timeFrom.minute),
                          DateTime(DateTime.now().year, DateTime.now().month,
                              DateTime.now().day, timeTo.hour, timeTo.minute),
                          vehicle.toMap(),
                          _currentName,
                          _category == category.Rider ? 1 : 0);
                      entryEntity.userId = _dbService.uid;
                      // _dbService.getTotalCollection().then((value) {
                        _dbService.addEntryEntityData(entryEntity,
                             _dbService.getSelectedCollection("tempEntry"));
                        Resources.registeredVehiclelist.add(vehicle);
                        Navigator.pop(context);
                      // });
                      // _dbService.getEntryEntities();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF015C92), // Background color
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        Align(
                          alignment: Alignment.center,
                          child: Text('Submit',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'Inter',
                                  color: Color(0xFFFFFFFF),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20)),
                        ),
                      ],
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
