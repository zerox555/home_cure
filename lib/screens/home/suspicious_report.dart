
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_cure/models/suspiciousEventReport.dart';
import 'package:home_cure/models/vehicle.dart';
import 'package:home_cure/services/resources.dart';
import 'package:home_cure/services/storage.dart';
import 'package:home_cure/services/database.dart';


class reportSuspicious extends StatefulWidget {
  const reportSuspicious({Key? key}) : super(key: key);

  @override
  State<reportSuspicious> createState() => _reportSuspiciousState();
}

enum vehicleType { Car, Motor, Van, Lorry }

class _reportSuspiciousState extends State<reportSuspicious> {
  vehicleType? _vehicleType;
  bool _isVisible = false;
  String _currentVehiclePlate = '';
  int vehicleT = 0;

  //check if vehicle plate is in db
  bool isVehicleSuspicious(String vehiclePlate) {
    bool isSuspicious = true;
    //load from db

    //load from static test
    Resources.registeredVehiclelist.forEach((element) {
      if (element.carPlate.toLowerCase() == vehiclePlate.toLowerCase()) {
        isSuspicious = false;
        return;
      }
    });
    return isSuspicious;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text("Report Suspicious Event",
              style: TextStyle(
                  fontFamily: 'Inter',
                  color: Colors.lightBlue[900],
                  fontWeight: FontWeight.bold,
                  fontSize: 22)),
          centerTitle: true,
          backgroundColor: Colors.lightBlueAccent[100],
        ),
        body: Container(
          margin: EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Vehicle Number Plate
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
//NumberPlate
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
                        padding: EdgeInsets.only(
                            left: 15, right: 15, top: 5, bottom: 5),
                        child: TextFormField(
                          decoration: InputDecoration(border: InputBorder.none),
                          onChanged: (val) {
                            setState(() {
                              _currentVehiclePlate = val;
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
                ),
              ),
              //Vehicle Type
              SizedBox(height: 20),
              Container(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
//Vehicle Type
                  Text('Vehicle Type: ',
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
              //Check button
              SizedBox(height: 30),
              Center(
                child: Container(
                  height: 60, //height of button
                  width: 150,

                  child: ElevatedButton(
                      onPressed: () {
//set if function here (if the vehicle number plate is equal to the one inside the database then display it out
//else function will direct to another page for more details
                        if (isVehicleSuspicious(_currentVehiclePlate)) {
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
                          setState(() {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                       detailSuspicious(_currentVehiclePlate,vehicleT)),
                            );
                          });
                        } else {
                          setState(() {
                            _isVisible = !_isVisible;
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFF015C92), // Background color
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(height: 20),
                          Align(
                            alignment: Alignment.center,
                            child: Text('Check',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: 'Inter',
                                    color: Color(0xFFFFFFFF),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20)),
                          ),
                        ],
                      )),
                ),
              ),
              SizedBox(height: 30),
              //SafeTextDisplay
              Visibility(
                visible: _isVisible,
                child: Center(
                  child: Text('Safe !! \n Registered Vehicle',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Inter',
                          color: Color(0xFF05FF00),
                          fontWeight: FontWeight.w600,
                          fontSize: 25)),
                ),
              ),
            ],
          ),
        ));
  }
}

class detailSuspicious extends StatefulWidget {

  String carPlate='';
  int vehicleType = 0;
  detailSuspicious(this.carPlate,this.vehicleType);

  @override
  State<detailSuspicious> createState() => _detailSuspiciousState();
}

class _detailSuspiciousState extends State<detailSuspicious> {
  final Storage storage =Storage();
  DatabaseService _dbService = DatabaseService(FirebaseAuth.instance.currentUser!.uid);
  String _currentAddress = '';
  String _currentDesc = '';
  String _currentUrl = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Report Suspicious Event",
            style: TextStyle(
                fontFamily: 'Inter',
                color: Colors.lightBlue[900],
                fontWeight: FontWeight.bold,
                fontSize: 22)),
        centerTitle: true,
        backgroundColor: Colors.lightBlueAccent[100],
      ),
      body: Container(
        margin: EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                  'Suspicious Vehicle Detected!! \nDo provide us more details. ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'Inter',
                      color: Color(0xFFFF3F3F),
                      fontWeight: FontWeight.w600,
                      fontSize: 20)),
            ),
            SizedBox(height: 20),
            Text('Additional Photo: ',
                style: TextStyle(
                    fontFamily: 'Inter',
                    color: Color(0xFF015C92),
                    fontWeight: FontWeight.w600,
                    fontSize: 16)),
            SizedBox(height: 10),
            Container(
              height: 100,
              width: 370,
              color: Colors.lightBlue,
            ),
            ElevatedButton(
                onPressed: () async {
                  final results = await FilePicker.platform.pickFiles(
                    allowMultiple: false,
                    type: FileType.custom,
                    allowedExtensions: ["png", "jpg"],
                  );

                  if(results == null){
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("no file selected"),
                      )
                    );
                    return null;


                  }
                  final path = results.files.single.path!;
                  final fileName = results.files.single.name;
                  storage.uploadFile(path, fileName).then((value){
                    _currentUrl = 'suspiciousActivity/$fileName';
                  });
                },
                child: Text("upload a file")),
            //where do the photo attachment

            //Vehicle Number Plate
            SizedBox(height: 20),
            Text('Occurance Street: ',
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
                  onChanged: (val){
                    setState(() {
                      _currentAddress = val;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the occurance street';
                    }
                    return null;
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            Text('Event Description (max 30 words) : ',
                style: TextStyle(
                    fontFamily: 'Inter',
                    color: Color(0xFF015C92),
                    fontWeight: FontWeight.w600,
                    fontSize: 16)),
            SizedBox(height: 10),
            Container(
              height: 100,
              decoration: BoxDecoration(
                color: Colors.lightBlue[100],
                borderRadius: new BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding:
                    EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
                child: TextFormField(
                  maxLines: 5,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText:
                          'Provide us details such as the suspicious activities and occurrence time.',
                      hintStyle: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF3288BB).withOpacity(0.4))),
                  onChanged: (val){
                    setState(() {
                      _currentDesc = val;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter event description';
                    }
                    return null;
                  },
                ),
              ),
            ),
            SizedBox(height: 30),
            Center(
              child: Container(
                height: 60, //height of button
                width: 150,

                child: ElevatedButton(
                    onPressed: () {
                      setState(() {

                      });
                      //add to db

                      SuspiciousEventReport suspiciousEventReport = SuspiciousEventReport(Vehicle(widget.carPlate,null,widget.vehicleType).toMap(), _currentAddress, _currentDesc);
                      suspiciousEventReport.imageUrl = _currentUrl;
                      _dbService.addSuspiciousEvent(suspiciousEventReport, _dbService.getSelectedCollection("suspiciousEvent"));

                      Resources.vehiclePlates.add(widget.carPlate);
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF015C92), // Background color
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        Align(
                          alignment: Alignment.center,
                          child: Text('Report',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'Inter',
                                  color: Color(0xFFFFFFFF),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20)),
                        ),
                      ],
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
