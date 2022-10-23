import 'package:flutter/material.dart';
import 'package:home_cure/screens/authenticate/register.dart';
import 'package:home_cure/screens/authenticate/sign_in.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignIn = true;

  void toggleView() {
    setState(()=>{
      showSignIn= !showSignIn
    });
  }

  @override
  Widget build(BuildContext context) {
    if(showSignIn){
      return SignIn(toggleView);
    }else{
      return Register(toggleView);
    }
  }
}
