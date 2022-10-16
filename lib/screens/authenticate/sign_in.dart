import 'package:flutter/material.dart';

import '../../services/auth.dart';
import '../../shared/constants.dart';
import '../../shared/loading.dart';

class SignIn extends StatefulWidget {
  // const SignIn({Key? key}) : super(key: key);

  final Function toggleView;
  SignIn(this.toggleView);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
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
      appBar: AppBar(
        backgroundColor: Colors.blue[100],
        elevation: 0.0,
        title: Text("Sign in to App"),
        actions: <Widget>[
          ElevatedButton.icon(
            onPressed: () {
              widget.toggleView();
            },
            icon: Icon(Icons.person),
            label: Text("Register"),
          )
        ],
      ),
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: 20),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: "Email"),
                    validator: (val) =>
                        val!.isEmpty ? "Please enter your email" : null,
                    onChanged: (val) {
                      setState(() => email = val);
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: "Password"),
                    validator: (val) => val!.length < 6
                        ? "Please enter a password >6 char"
                        : null,
                    obscureText: true,
                    onChanged: (val) {
                      setState(() => password = val);
                    },
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            loading= true;
                          });
                          dynamic result = await _authService.signInWithEmailAndPassword(email, password);
                          if (result == null){
                            setState(() {
                              error = 'Something went wrong! Try again ';
                              loading = false;
                            });
                          }
                        }
                      },
                      child: Text("Sign in",
                          style: TextStyle(color: Colors.white))),
                  SizedBox(
                    height: 12.0,
                  ),
                  Text(
                    error,
                    style: TextStyle(color: Colors.red, fontSize: 14.0),
                  )
                ],
              ))),
    );
  }
}
