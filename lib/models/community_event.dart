import 'package:flutter/material.dart';

class CommunityEvent{

  String eventTitle;
  String eventDesc;
  DateTime timeOfRelease;
  String userName;
  String? address='';
  //address is optional for offical posts
  String? imageUrl='';
  bool isFromLocal = true;

  CommunityEvent(this.userName,this.eventTitle,this.eventDesc,this.timeOfRelease);
}