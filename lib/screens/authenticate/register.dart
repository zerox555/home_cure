import 'package:flutter/material.dart';

import '../../services/auth.dart';
import '../../shared/constants.dart';
import '../../shared/loading.dart';


class Register extends StatefulWidget {
  // const Register({Key? key}) : super(key: key);

  final Function toggleView;
  Register(this.toggleView);
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _authService = AuthService();
  //identify form
  final _formKey = GlobalKey<FormState>();
  bool loading = false;


  //text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading? Loading():Scaffold(
      backgroundColor: Colors.blue[23],
      appBar: null,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
            child: Center(
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(height: 130),
                      Image.asset(
                        'Image/logo.jpg',
                        height: 200,
                        width: 200,
                        fit: BoxFit.fill,
                      ),
                      SizedBox(height: 10),
                      Text(
                          "HomeCure",
                          style: TextStyle(
                              fontFamily: 'Noto',
                              color: Color(0xFF3288BB),
                              letterSpacing: 2,
                              fontWeight: FontWeight.bold,
                              fontSize: 28)
                      ),
                      SizedBox(height: 20),
                      Stack(children: [
                        Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.lightBlue[100],
                              borderRadius: new BorderRadius.circular(10.0),
                            )),
                        Padding(
                          padding:EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5) ,
                          child: TextFormField(
                            decoration:InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Registered Email',
                                hintStyle: TextStyle(fontSize: 16, color:Color(0xFF3288BB).withOpacity(01))
                            ),
                            validator: (val)=> val!.isEmpty ? "Please enter your email": null ,
                            onChanged: (val) {
                              setState(() => email = val);
                            },
                          ),
                        )
                      ],),
                      SizedBox(height: 20),
                      Stack(children: [
                        Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.lightBlue[100],
                              borderRadius: new BorderRadius.circular(10.0),
                            )),
                        Padding(
                          padding:EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5) ,
                          child: TextFormField(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'New Password',
                                hintStyle: TextStyle(fontSize: 16, color:Color(0xFF3288BB).withOpacity(01))
                            ),
                            validator: (val)=> val!.length<6 ? "Please enter a password >6 char": null ,
                            obscureText: true,
                            onChanged: (val) {
                              setState(() => password = val);
                            },
                          ),
                        )
                      ],),
                      SizedBox(height: 20),
                      Row(children: [
                        Expanded(
                          child: Container(
                            height:40, //height of button
                            width:100,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Color(0xFF015C92), // Background color
                                ),
                                onPressed: () async {
                                  if(_formKey.currentState!.validate()){
                                    setState(() {
                                      loading= true;
                                    });
                                    dynamic result = await _authService.registerWithEmailAndPassword(email, password);
                                    if (result == null){
                                      setState(() {
                                        error = 'please supply a valid email';
                                        loading = false;
                                      });
                                    }
                                  }
                                },
                                child: Text("Register",
                                    style: TextStyle(
                                        fontFamily: 'Inter',
                                        color: Color(0xFFFFFFFF),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15))),
                          ),
                        ),
                        SizedBox(width: 10.0),
                        Text(
                          error,
                          style: TextStyle(color: Colors.red,fontSize: 14.0),
                        ),
                        Expanded(
                          child: Container(
                            height:40, //height of button
                            width:100,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Color(0xFF015C92), // Background color
                              ),
                              onPressed: () {
                                widget.toggleView();
                              },
                              child: Text("Back",
                                  style: TextStyle(
                                      fontFamily: 'Inter',
                                      color: Color(0xFFFFFFFF),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15)),
                            ),
                          ),
                        )
                      ],)
                    ],
                  )),
            )),
      ),
    );
  }
}
