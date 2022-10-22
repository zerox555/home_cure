import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../models/contact.dart';
import '../../services/resources.dart';
import 'contacts_setting.dart';

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
        title: Text("Emergency Contacts"),
      ),
      body: ListView.builder(
          itemCount: Resources.emergencyContactlist.length,
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
                      title: Text(Resources.emergencyContactlist[index].name),
                      subtitle:
                          Text(Resources.emergencyContactlist[index].telNo),
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
                ]));
          }),
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
