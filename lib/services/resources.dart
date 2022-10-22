import 'package:flutter/material.dart';
import 'package:home_cure/models/discussion.dart';
import 'package:home_cure/models/faq.dart';
import 'package:home_cure/models/patrol_route.dart';
import 'package:home_cure/screens/profile/emergency_contact.dart';

import '../models/community_event.dart';
import '../models/contact.dart';
import '../models/patrol_point.dart';
import '../models/security_tips.dart';
import '../models/vehicle.dart';

class Resources {
  static List<CommunityEvent> communityEventList = [];
  static List<DiscussionPost> discussionPostList = [];
  static List<String> vehiclePlates = [];
  static List<Contact> emergencyContactlist = [];
  static List<Vehicle> registeredVehiclelist = [];

  //hardcoded return method for security tips page
  static List<SecurityTip> securityTipsInFile() {
    List<SecurityTip> securityTips = [];
    securityTips.add(SecurityTip(0, "Dont leave your belongings in the house"));
    securityTips
        .add(SecurityTip(1, "Get in a good relationship with your neighours"));
    securityTips
        .add(SecurityTip(2, "Dont poke your nose in where it doesnt belong"));
    securityTips.add(SecurityTip(3, "Remember to lock your front door"));
    return securityTips;
  }

  static List<Faq> faqsInFile() {
    List<Faq> Faqs = [];
    Faqs.add(Faq(0, "What should i do if the app stops working?",
        "Close the app and restart it"));
    Faqs.add(
        Faq(1, "How do i pay using the app?", "Go to billing and click pay"));
    Faqs.add(Faq(2, "Can i use the app offline",
        "the app requires an active internet connection to work"));
    Faqs.add(Faq(3, "Does the app collect my personal data",
        "We only collect as much information as you agree to when you sign up"));

    return Faqs;
  }

  static List<String> initializeVehiclePlates() {
    vehiclePlates.add("WPA2012");
    vehiclePlates.add("EPW2457");
    vehiclePlates.add("QOG4962");
    vehiclePlates.add("PEJ3353");
    vehiclePlates.add("GGO2315");
    return vehiclePlates;
  }

  static PatrolRoute getPatrolRoute() {
    List<Map<String, dynamic>> patrolPointsList = [];
    patrolPointsList.add(
        PatrolPoint(true, "21,  us2/4b", {'lat': 3.048402, 'lng': 101.572358})
            .toMap());
    patrolPointsList.add(
        PatrolPoint(true, "24,  us2/4b", {'lat': 3.048433, 'lng': 101.573292})
            .toMap());
    patrolPointsList.add(
        PatrolPoint(false, "26,  us2/4b", {'lat': 3.047016, 'lng': 101.573269})
            .toMap());
    patrolPointsList.add(
        PatrolPoint(false, "28,  us2/4b", {'lat': 3.047005, 'lng': 101.572352})
            .toMap());
    patrolPointsList.add(
        PatrolPoint(false, "29,  us2/4b", {'lat': 3.045196, 'lng': 101.572355})
            .toMap());
    patrolPointsList.add(
        PatrolPoint(false, "23,  us2/4b", {'lat': 3.045162, 'lng': 101.573777})
            .toMap());

    PatrolRoute patrol = PatrolRoute("Guard usj3/4b", patrolPointsList);
    return patrol;
  }

  static void initializeEmergencyContacts(){
    emergencyContactlist.add(Contact("adam", "012-32581242"));
    emergencyContactlist.add(Contact("Mom", "016-54541342"));

  }

  static void initializeRegisteredVehicles(){
    registeredVehiclelist.add(Vehicle("WPA2012",DateTime(2019, 6, 11, 13, 14, 13), 2));
    registeredVehiclelist.add(Vehicle("EPW2457",DateTime(2021, 1, 1, 13, 5, 10), 1));
    registeredVehiclelist.add(Vehicle("QOG4962",DateTime(2020, 7, 17, 16, 10, 10), 2));

  }

  static List<CommunityEvent> initializeCommunityEvents() {
    communityEventList.add(CommunityEvent(
        "USJ 3 resident association",
        "New breakfast store opening soon!",
        "This is the event desc",
        DateTime(2021, 4, 10, 12, 10, 10)));
    communityEventList.add(CommunityEvent(
        "USJ 3 resident association",
        "New gym store opening soon!",
        "This is the event desc",
        DateTime(2020, 5, 12, 12, 10, 10)));
    communityEventList.add(CommunityEvent(
        "USJ 3 resident association",
        "Partnership with local grocery store",
        "This is the event desc",
        DateTime(2021, 4, 15, 12, 10, 10)));

    return communityEventList;
  }

  static List<DiscussionPost> initializeDiscussionPosts() {
    discussionPostList.add(DiscussionPost(
        "Lee Ming Huat",
        "Any 1 interested in jogging together?",
        "jogging from 9am to 10 am, lmk if you are interested ",
        DateTime(2021, 4, 23, 22, 10, 10)));
    discussionPostList.add(DiscussionPost(
        "Ali bin Abu",
        "WYN3432 whose car is this?",
        "owner of the car above please remove your car from my front gate asap thanks this is some fake text asap thanks this is some fake text asap thanks this is some fake text asap thanks this is some fake text asap thanks this is some fake text asap thanks this is some fake text asap thanks this is some fake text",
        DateTime(2019, 6, 11, 13, 10, 10)));
    discussionPostList.add(DiscussionPost(
        "Ryan",
        "I have a few dogs up for adoption",
        "all was stray dogs, lmk if you are interested ",
        DateTime(2021, 4, 23, 22, 10, 10)));

    return discussionPostList;
  }
}
