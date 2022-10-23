import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../models/contact.dart';
import '../../services/resources.dart';
import 'contacts_setting.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class EmergencyContacts extends StatefulWidget {
  @override
  State<EmergencyContacts> createState() => _EmergencyContactsState();
}

class _EmergencyContactsState extends State<EmergencyContacts> {

  int? _currentSelectedIndex;
  String _currentSelectedName = '';
  String _currentSelectedNumber = '';
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
              child: SettingsForm(_currentSelectedIndex, _currentSelectedName,
                  _currentSelectedNumber, _isEdit, refresh));
        });
  }

  @override
  Widget build(BuildContext context) {
     _currentSelectedIndex = null;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
            'Emergency Contact',
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
          itemCount: Resources.emergencyContactlist.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
                margin: EdgeInsets.fromLTRB(30, 30, 30, 0),
                padding: EdgeInsets.all(10.0),
                width: 180,
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
                child: Row(
                  children: [
                    Expanded(
                      child: Column(children: [
                        ListTile(
                            title: Text(Resources.emergencyContactlist[index].name,
                                style: TextStyle(
                                    fontFamily: 'Inter',
                                    color: Colors.lightBlue[900],
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18)),
                            subtitle:
                                Text(Resources.emergencyContactlist[index].telNo,
                                    style: TextStyle(
                                    fontFamily: 'Inter',
                                    color: Colors.lightBlue[900],
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15)),
                            onTap: () {
                                print("index is $index");
                                _currentSelectedIndex = index;
                                _currentSelectedName =
                                    Resources.emergencyContactlist[index].name;
                                _currentSelectedNumber =
                                    Resources.emergencyContactlist[index].telNo;
                                _isEdit = true;
                                print(_isEdit);
                                _showSettingsPanel();
                            })
                      ]),
                    ),
                    Expanded(
                      child: IconButton(
                          onPressed: () async {
                            FlutterPhoneDirectCaller.callNumber(Resources.emergencyContactlist[index].telNo);
                          },
                          icon: Icon(Icons.call,
                          size: 30,
                          color: Color(0xFF015C92),)),
                    )
                  ],
                ));
          }),
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

  // return StreamBuilder<QuerySnapshot>(
  //   stream: _usersStream,
  //   builder: (context, snapshot) {
  //     return Scaffold(
  //         appBar: AppBar(
  //         title: Text("Emergency contacts page"),
  //
  //     ),
  //     body: ListView.builder(
  //         itemCount:contactList.length,
  //         itemBuilder: (BuildContext context,int index){
  //           DocumentSnapshot documentSnapshot = snapshot.data!.docs[index];
  //           var contacts = documentSnapshot.get("age");
  //           print(contacts);
  //           return Container(
  //             decoration: const BoxDecoration(
  //               border: Border(
  //                 top: BorderSide(color: Colors.black),
  //                 left: BorderSide(),
  //                 right: BorderSide(),
  //                 bottom: BorderSide(color: Colors.black),
  //               ),
  //             ),
  //             child: Column(
  //               children: [
  //                 Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
  //                 Text(contactList[index].telNo),
  //                 Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
  //
  //               ],
  //             ),
  //           );
  //
  //         }));
  //   }
  // );
}
