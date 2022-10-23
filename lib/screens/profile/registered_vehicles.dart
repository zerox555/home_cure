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
      appBar: AppBar(
        elevation: 0,
        title: Text(
            'Registered Vehicles',
            style: TextStyle(
                fontFamily: 'Inter',
                color: Colors.lightBlue[900],
                fontWeight: FontWeight.bold,
                fontSize: 22)
        ),
        centerTitle: true,
        backgroundColor: Colors.lightBlueAccent[100],

      ),
      body: ListView.builder(
        itemCount: Resources.registeredVehiclelist.length,
        itemBuilder: (BuildContext context, int index) {
          return SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              margin: EdgeInsets.fromLTRB(30, 30, 30, 0),
              padding: EdgeInsets.all(10.0),
              width: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xFFE0F0FF),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFFC9D9E8),
                      spreadRadius: 0,
                      blurRadius: 16,
                      offset: Offset(8, 8),
                    ),
                    BoxShadow(
                      color: Color(0xFFFFFFFF),
                      spreadRadius: 0,
                      blurRadius: 16,
                      offset: Offset(-8, -8),
                    )
                  ]),
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
                    title: Text(Resources.registeredVehiclelist[index].carPlate,
                        style: TextStyle(
                            fontFamily: 'Inter',
                            color: Colors.lightBlue[900],
                            fontWeight: FontWeight.w600,
                            fontSize: 18)
                    ),
                    subtitle: Text(Resources
                        .registeredVehiclelist[index].timeOfReg
                        .toString(),style: TextStyle(
                        fontFamily: 'Inter',
                        color: Colors.lightBlue[900],
                        fontWeight: FontWeight.w500,
                        fontSize: 14)))

              ]),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
          _isEdit = false;
          _showSettingsPanel();
        },
        backgroundColor: Color(0xFF015C92),
        child: const Icon(Icons.add),
      ),
    );
  }
}
