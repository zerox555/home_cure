import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';
import '../shared/constants.dart';
import 'authenticate/authenticate.dart';
import 'home/home.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(isProduction){
      final appUser = Provider.of<AppUser?>(context);
      //return either Home or Authenticate widget
      if (appUser == null) {
        return Authenticate();
      } else {
        return Home();
      }
    }else{
      return Home();
    }

  }
}
