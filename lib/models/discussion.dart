import 'package:flutter/material.dart';

class DiscussionPost{

  String eventTitle;
  String eventDesc;
  DateTime timeOfRelease;
  String userName;
  String? address='';
  //address is optional for offical posts
  String? imageUrl='';

  DiscussionPost(this.userName,this.eventTitle,this.eventDesc,this.timeOfRelease);
}