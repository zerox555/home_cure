import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_cure/models/contact.dart';
import 'package:home_cure/models/vehicle.dart';
import 'package:home_cure/services/database.dart';

import '../../models/user.dart';
import '../../services/auth.dart';

class ProfileSettings extends StatelessWidget {
  Function updateParent;

  ProfileSettings(this.updateParent);

  @override
  Widget build(BuildContext context) {
    return FormPage('Edit Profile',updateParent);
  }
}

class FormPage extends StatefulWidget {

  Function updateParent;

  FormPage(this.title,this.updateParent);
  final String title;

  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(widget.title,
            style: TextStyle(
                fontFamily: 'Inter',
                color: Colors.lightBlue[900],
                fontWeight: FontWeight.bold,
                fontSize: 22)),
        centerTitle: true,
        backgroundColor: Colors.lightBlueAccent[100],
      ),
      body: Container(
          padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
          child: SignUpForm(widget.updateParent)),
    );
  }
}

class SignUpForm extends StatefulWidget {
  Function updateParent;
  SignUpForm(this.updateParent);
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final _passKey = GlobalKey<FormFieldState>();

  String _name = '';
  String _email = '';
  int _age = -1;
  String _maritalStatus = 'single';
  int _selectedGender = 0;
  String _address = '';
  String _currentTelNo = '';
  bool _termsChecked = true;

  List<DropdownMenuItem<int>> genderList = [];

  void loadGenderList() {
    genderList = [];
    genderList.add(const DropdownMenuItem(
      child: Text('Male',
          style: TextStyle(
              fontFamily: 'Inter',
              color: Color(0xFF015C92),
              fontWeight: FontWeight.bold,
              fontSize: 16)),
      value: 0,
    ));
    genderList.add(const DropdownMenuItem(
      child: Text('Female',
          style: TextStyle(
              fontFamily: 'Inter',
              color: Color(0xFF015C92),
              fontWeight: FontWeight.bold,
              fontSize: 16)),
      value: 1,
    ));
    genderList.add(const DropdownMenuItem(
      child: Text('Others',
          style: TextStyle(
              fontFamily: 'Inter',
              color: Color(0xFF015C92),
              fontWeight: FontWeight.bold,
              fontSize: 16)),
      value: 2,
    ));
  }

  @override
  Widget build(BuildContext context) {
    loadGenderList();
    // Build a Form widget using the _formKey we created above
    return Form(
        key: _formKey,
        child: ListView(
          children: getFormWidget(),
        ));
  }

  List<Widget> getFormWidget() {
    List<Widget> formWidget = [];

    formWidget.add(TextFormField(
      decoration: const InputDecoration(
          labelText: 'Enter Name',
          labelStyle: TextStyle(
              fontFamily: 'Inter',
              color: Color(0xFF015C92),
              fontWeight: FontWeight.bold,
              fontSize: 16),
          hintText: 'Name',
          hintStyle: TextStyle(
              fontFamily: 'Inter',
              color: Color(0xFF015C92),
              fontWeight: FontWeight.w500,
              fontSize: 16)),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter a name';
        } else {
          return null;
        }
      },
      onSaved: (value) {
        setState(() {
          _name = value.toString();
        });
      },
    ));

    validateEmail(String? value) {
      if (value!.isEmpty) {
        return 'Please enter mail';
      }

      Pattern pattern =
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regex = RegExp(pattern.toString());
      if (!regex.hasMatch(value.toString())) {
        return 'Enter Valid Email';
      } else {
        return null;
      }
    }

    formWidget.add(SizedBox(height: 10));
    formWidget.add(TextFormField(
      decoration: const InputDecoration(
          labelText: 'Enter Email',
          hintText: 'Email',
          labelStyle: TextStyle(
              fontFamily: 'Inter',
              color: Color(0xFF015C92),
              fontWeight: FontWeight.bold,
              fontSize: 16),
          hintStyle: TextStyle(
              fontFamily: 'Inter',
              color: Color(0xFF015C92),
              fontWeight: FontWeight.w500,
              fontSize: 16)),
      keyboardType: TextInputType.emailAddress,
      validator: validateEmail,
      onSaved: (value) {
        setState(() {
          _email = value.toString();
        });
      },
    ));
    formWidget.add(SizedBox(height: 10));
    formWidget.add(TextFormField(
      decoration: const InputDecoration(
          labelText: 'Enter Telephone No',
          hintText: 'Telephone No',
          labelStyle: TextStyle(
              fontFamily: 'Inter',
              color: Color(0xFF015C92),
              fontWeight: FontWeight.bold,
              fontSize: 16),
          hintStyle: TextStyle(
              fontFamily: 'Inter',
              color: Color(0xFF015C92),
              fontWeight: FontWeight.w500,
              fontSize: 16)),
      keyboardType: TextInputType.phone,
      validator: null,
      onSaved: (value) {
        setState(() {
          if (value!.isNotEmpty) {
            _currentTelNo = value!;
          } else {
            _currentTelNo = '';
          }
        });
      },
    ));
    formWidget.add(SizedBox(height: 10));
    formWidget.add(TextFormField(
      decoration: const InputDecoration(
          hintText: 'Address',
          labelText: 'Enter Address',
          labelStyle: TextStyle(
              fontFamily: 'Inter',
              color: Color(0xFF015C92),
              fontWeight: FontWeight.bold,
              fontSize: 16),
          hintStyle: TextStyle(
              fontFamily: 'Inter',
              color: Color(0xFF015C92),
              fontWeight: FontWeight.w500,
              fontSize: 16)),
      keyboardType: TextInputType.streetAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter age';
        } else {
          return null;
        }
      },
      onSaved: (value) {
        setState(() {
          if (value!.isNotEmpty) {
            _address = value!;
          } else {
            _address = '';
          }
        });
      },
    ));
    formWidget.add(SizedBox(height: 10));
    formWidget.add(DropdownButton(
      hint: const Text('Select Gender'),
      items: genderList,
      value: _selectedGender,
      onChanged: (value) {
        setState(() {
          _selectedGender = int.parse(value.toString());
        });
      },
      isExpanded: true,
    ));


    formWidget.add(SizedBox(height: 10));

    formWidget.add(
      TextFormField(
        key: _passKey,
        obscureText: true,
        decoration: const InputDecoration(
            hintText: 'Age',
            labelText: 'Enter Age',
            labelStyle: TextStyle(
                fontFamily: 'Inter',
                color: Color(0xFF015C92),
                fontWeight: FontWeight.bold,
                fontSize: 16),
            hintStyle: TextStyle(
                fontFamily: 'Inter',
                color: Color(0xFF015C92),
                fontWeight: FontWeight.w500,
                fontSize: 16)),
        keyboardType: TextInputType.number,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please Enter age';
          } else {
            return null;
          }
        },
        onChanged: (value) {
          setState(() {
            _age = int.parse(value!);
          });
        },
      ),
    );
    formWidget.add(SizedBox(height: 10));

    formWidget.add(CheckboxListTile(
      value: _termsChecked,
      onChanged: (value) {
        setState(() {
          _termsChecked = value.toString().toLowerCase() == 'true';
        });
      },
      subtitle: !_termsChecked
          ? const Text(
              'Required',
              style: TextStyle(color: Colors.red, fontSize: 12.0),
            )
          : null,
      title: const Text('I agree to the terms and condition',
          style: TextStyle(
              fontFamily: 'Inter',
              color: Color(0xFF015C92),
              fontWeight: FontWeight.w600,
              fontSize: 15)),
      controlAffinity: ListTileControlAffinity.leading,
    ));

    void onPressedSubmit() {
      if (_formKey.currentState!.validate() && _termsChecked) {
        String _gender  ='';
        switch(_selectedGender){
          case 0: _gender = "male";
          break;
          case 1: _gender = "female";
          break;
          case 2: _gender = "others";
          break;
        }
        _formKey.currentState?.save();
        //put AppUser data inside
        String? _uId = FirebaseAuth.instance.currentUser?.uid;
        AppUser? appUser = AppUser(_uId ?? '');
        appUser.registeredVehicles = Vehicle.ConvertVehiclesToMap([
          Vehicle("WPH23ds", DateTime.now(), 1),
          Vehicle("GRT1325", DateTime.now(), 3),
          Vehicle("GGG3424", DateTime.now(), 0)
        ].toList());
        appUser.emergencyContacts = Contact.ConvertContactsToMap([
          Contact("adam", "012-343232"),
          Contact("mom", "014-4341212")
        ].toList());
        appUser.name = _name;
        appUser.email = _email;
        appUser.age = _age;
        appUser.address = _address;
        appUser.gender = _gender;
        appUser.phoneNo = _currentTelNo;
        DatabaseService _dbService = DatabaseService(_uId ?? '');

        _dbService.updateAppUserData(
            appUser, _dbService.getSelectedCollection("users"));
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Form Submitted')));
        widget.updateParent();
      }
    }

    formWidget.add(SizedBox(height: 10));

    formWidget.add(Expanded(
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Color(0xFF015C92), // Background color
          ),
          child: const Text('Submit',
              style: TextStyle(
                  fontFamily: 'Inter',
                  color: Color(0xFFFFFFFF),
                  fontWeight: FontWeight.w500,
                  fontSize: 15)),
          onPressed: onPressedSubmit),
    ));

    return formWidget;
  }
}
