import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_cure/models/contact.dart';
import 'package:home_cure/models/vehicle.dart';
import 'package:home_cure/services/database.dart';
import 'package:home_cure/services/resources.dart';

import '../../models/user.dart';
import '../../shared/constants.dart';

class VehicleSettingsForm extends StatefulWidget {

  int? selectedIndex;
  String name;
  bool isEdit;
  Function refreshParent;
  VehicleSettingsForm(this.selectedIndex, this.name, this.isEdit,
      this.refreshParent);

  @override
  State<VehicleSettingsForm> createState() => _VehicleSettingsFormState();
}

enum vehicleType { Car, Motor, Van, Lorry }

class _VehicleSettingsFormState extends State<VehicleSettingsForm> {
  final _formKey = GlobalKey<FormState>();
  vehicleType? _vehicleType;
  String _currentVehiclePlate='';

  @override
  initState() {
    initializeFormValues();
  }

  void initializeFormValues() {
    if (widget.isEdit) {
      _currentVehiclePlate = widget.name;
    } else {
      _currentVehiclePlate = '';
    }
  }



  @override
  Widget build(BuildContext context) {
    //form values;


      return Form(
          key: _formKey,
          child: Column(children: <Widget>[
            Text(widget.isEdit == false ? "add new vehicle" : "edit vehicle",
                style: TextStyle(fontSize: 18.0)),
            SizedBox(height: 20.0),
            TextFormField(
              initialValue: _currentVehiclePlate,
              decoration: textInputDecoration.copyWith(
                  hintText: "Contact Name"),
              validator: (val) =>
              val!.isEmpty ? "Please enter a contact name" : null,
              onChanged: (val) {
                setState(() => _currentVehiclePlate = val);
              },
            ),
            SizedBox(height: 20.0),
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
                ),
                ElevatedButton(
                    child: Text(
                      "update",
                      style: TextStyle(color: Colors.lightBlue),
                    ),
                    onPressed: () {
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
                      //add to firebase if come by add function
                      if (widget.selectedIndex == null) {
                        Resources.registeredVehiclelist
                            .add(Vehicle(_currentVehiclePlate,DateTime.now(),vehicleT));
                        // _dbService.getProfile().then((futureAppUser) {
                        //   appUser = futureAppUser as AppUser;
                        //   appUser!.emergencyContacts!.addAll(
                        //       Contact.ConvertContactsToMap([
                        //         Contact(_currentContactName, _currentContactNumber)
                        //       ].toList()));
                        //   _dbService.updateAppUserData(
                        //       appUser, _dbService.getSelectedCollection("users"));
                        // }
                      } else {
                        Resources.registeredVehiclelist[widget.selectedIndex!].carPlate = _currentVehiclePlate;
                        // _dbService.getProfile().then((futureAppUser) {
                        //   appUser = futureAppUser as AppUser;
                        //   print(_currentContactNumber);
                        //   appUser.emergencyContacts![widget.selectedIndex!]['contactName'] = _currentContactName;
                        //   appUser.emergencyContacts![widget.selectedIndex!]['phoneNo'] = _currentContactNumber;
                        //   _dbService.updateAppUserData(
                        //       appUser, _dbService.getSelectedCollection("users"));
                        // });

                      }
                      widget.refreshParent();
                    })

              ],
            )
          ],
          ),
      );//drop down

            //edit

            //else update

        //slide

    }



}