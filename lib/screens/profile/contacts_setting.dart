import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_cure/models/contact.dart';
import 'package:home_cure/services/database.dart';
import 'package:home_cure/services/resources.dart';

import '../../models/user.dart';
import '../../shared/constants.dart';

class SettingsForm extends StatefulWidget {
  int? selectedIndex;
  String name;
  String number;
  bool isEdit;
  Function refreshParent;
  SettingsForm(this.selectedIndex, this.name, this.number, this.isEdit,
      this.refreshParent);


  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();


  //form values;
  String _currentContactName = '';
  String _currentContactNumber = '';

  void initializeFormValues() {
    if (widget.isEdit) {
      _currentContactName = widget.name;
      _currentContactNumber = widget.number;
    } else {
      _currentContactName = '';
      _currentContactNumber = '';
    }
  }

  @override
  initState() {
    initializeFormValues();
  }

  @override
  Widget build(BuildContext context) {
    // initializeFormValues();

    return Form(
        key: _formKey,
        child: Column(children: <Widget>[
          Text(widget.isEdit == false ? "add new contact" : "edit contact",
              style: TextStyle(fontSize: 18.0)),
          SizedBox(height: 20.0),
          TextFormField(
            initialValue: _currentContactName,
            decoration: textInputDecoration.copyWith(hintText: "Contact Name"),
            validator: (val) =>
                val!.isEmpty ? "Please enter a contact name" : null,
            onChanged: (val) {
              setState(() => _currentContactName = val);
            },
          ),
          SizedBox(height: 20.0),
          TextFormField(
            initialValue: _currentContactNumber,
            decoration: textInputDecoration.copyWith(hintText: "Phone No"),
            keyboardType: TextInputType.number,
            validator: (val) =>
                val!.isEmpty ? "Please enter a phone Number" : null,
            onChanged: (val) {
              setState(() => _currentContactNumber = val);
            },
          ),
          SizedBox(height: 20.0),
          //drop down
          ElevatedButton(
              child: Text(
                "update",
                style: TextStyle(color: Colors.lightBlue),
              ),
              onPressed: () {
                //add to firebase if come by add function
                if (widget.selectedIndex == null) {
                  print("Add operation with selected Index ${widget.selectedIndex}");
                  print(_currentContactName);
                  print(_currentContactNumber);
                  Resources.emergencyContactlist
                      .add(Contact(_currentContactName, _currentContactNumber));
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
                  // _dbService.getProfile().then((futureAppUser) {
                  //   appUser = futureAppUser as AppUser;
                  //   print(_currentContactNumber);
                  //   appUser.emergencyContacts![widget.selectedIndex!]['contactName'] = _currentContactName;
                  //   appUser.emergencyContacts![widget.selectedIndex!]['phoneNo'] = _currentContactNumber;
                  //   _dbService.updateAppUserData(
                  //       appUser, _dbService.getSelectedCollection("users"));
                  // });
                  print("edit operation with selected Index ${widget.selectedIndex}");
                  print("before name:${Resources.emergencyContactlist[widget.selectedIndex!].name}");
                  print("after name:${_currentContactName}");
                  Resources.emergencyContactlist[widget.selectedIndex!].name =
                      _currentContactName;
                  print(Resources.emergencyContactlist[widget.selectedIndex!].telNo);
                  print(_currentContactNumber);
                  Resources.emergencyContactlist[widget.selectedIndex!].telNo =
                      _currentContactNumber;
                }
                widget.refreshParent();
              })

          //edit

          //else update
        ])
        //slider

        );
  }
}
