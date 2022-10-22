import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:home_cure/screens/profile/vehicle_setting.dart';

import '../../models/vehicle.dart';
import '../../services/resources.dart';

class RegisteredVehicles extends StatefulWidget {
  @override
  State<RegisteredVehicles> createState() => _RegisteredVehiclesState();
}

class _RegisteredVehiclesState extends State<RegisteredVehicles> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('users').snapshots();
  int? _currentSelectedIndex;
  String _currentSelectedCarPlate = '';
  bool _isEdit = false;

  refresh() {
    setState(() {
      Resources.emergencyContactlist;
    });
  }

  void _showSettingsPanel() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: VehicleSettingsForm(_currentSelectedIndex,
                  _currentSelectedCarPlate, _isEdit, refresh));
        });
  }

  @override
  Widget build(BuildContext context) {
    _currentSelectedIndex = null;
    return Scaffold(
      appBar: AppBar(title: Text("Registered Vehicles")),
      body: ListView.builder(
        itemCount: Resources.registeredVehiclelist.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.black),
                left: BorderSide(),
                right: BorderSide(),
                bottom: BorderSide(color: Colors.black),
              ),
            ),
            child: Column(children: [
              ListTile(
                onTap: (){
                  _currentSelectedIndex = index;
                  _currentSelectedCarPlate =
                      Resources.registeredVehiclelist[index].carPlate;
                  _isEdit = true;
                  print(_isEdit);
                  _showSettingsPanel();
                },
                  title: Text(Resources.registeredVehiclelist[index].carPlate),
                  subtitle: Text(Resources
                      .registeredVehiclelist[index].timeOfReg
                      .toString()))

            ]),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
          _isEdit = false;
          _showSettingsPanel();
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
    );
  }
}
