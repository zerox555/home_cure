import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';
import '../services/resources.dart';
import '../shared/constants.dart';
import 'authenticate/authenticate.dart';
import 'home/home.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  static void initializeResources(){
  }
  @override
  Widget build(BuildContext context) {
    if(isProduction){
      final appUser = Provider.of<AppUser?>(context);
      //return either Home or Authenticate widget
      if (appUser == null) {
        return Authenticate();
      } else {
        if(!Resources.executed){
          Resources.initializeCommunityEvents();
          Resources.initializeDiscussionPosts();
          // Resources.initializeVehiclePlates();
          // Resources.initializeEmergencyContacts();
          // Resources.initializeRegisteredVehicles();
          Resources.initializeReportStatus();
          Resources.initializeIncidenceReportList();
          Resources.executed = true;
        }
        return Home();
      }
    }else{
      return Home();
    }

  }
}
