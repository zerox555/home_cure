import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_cure/models/discussion.dart';
import 'package:home_cure/models/faq.dart';
import 'package:home_cure/models/incidence_report.dart';
import 'package:home_cure/models/patrol_route.dart';
import 'package:home_cure/screens/profile/emergency_contact.dart';

import '../models/community_event.dart';
import '../models/contact.dart';
import '../models/patrol_point.dart';
import '../models/repor_status.dart';
import '../models/security_tips.dart';
import '../models/vehicle.dart';

class Resources {
  static List<CommunityEvent> communityEventList = [];
  static List<DiscussionPost> discussionPostList = [];
  // static List<String> vehiclePlates = [];
  static List<Contact> emergencyContactlist = [];
  static List<Vehicle> registeredVehiclelist = [];
  static List<ReportStatus> reportStatusList = [];
  static List<IncidenceReport> incidenceReportList = [];

  //hardcoded return method for security tips page
  static List<SecurityTip> securityTipsInFile() {
    List<SecurityTip> securityTips = [];
    securityTips.add(SecurityTip(1, 'Make friends with neighbors',
        'Familiarizing yourself with neighbors can be a win-win situation. Offer yourself as a resource in case of emergencies or help needed on their end; some neighbors might reciprocate the offer. See if they’re comfortable sharing their needs.'));
    securityTips.add(SecurityTip(2, 'Organize neighborhood safety efforts',
        'Consider giving a Neighborhood Watch group a go in your neck of the woods. If you don’t know where to start with a neighborhood association, we outlined the steps to get Neighborhood Watch started in your area.'));
    securityTips.add(SecurityTip(3, 'Keep up your yard',
        'A well-kept yard can help deter crime since trimmed foliage offers fewer places to hide. And fences can, of course, keep unwanted visitors out.'));

    securityTips.add(SecurityTip(4, 'Exercise caution when out of town',
        'To choose targets, burglars rely most on easily scannable visual cues.2 Details like building type and signs of vacancy fall under this umbrella. We can’t overstate the importance of making it look like you’re home when you are away.'));

    securityTips.add(SecurityTip(5, 'Close windows and blinds at night',
        'A big-screen TV is a less enticing steal if no one knows it’s there. Leaving your blinds open and lights on at night provides a free look into your house, its layout, and the habits of its occupants. And leaving windows open at night or when you’re gone is an invitation for an uninvited guest to come on in.'));
    securityTips.add(SecurityTip(6, 'Improve lighting on your street',
        'Burglars often prefer to target neighborhoods with lower residential density.3 So if your neighborhood has few houses and lots of space, take special care to ensure that space is well lit. Streetlamps are not the only way to do this.'));

    securityTips.add(SecurityTip(7, 'Install a security system',
        'Overall, one of the surest options for crime prevention in your neighborhood is to get a home security system and use it properly. We regularly update our list of the ten best home security systems—these are your best bets.'));

    securityTips.add(SecurityTip(8, 'If you see something, say something',
        'It’s not just for airports—being diligent in your neighborhood and speaking up when you see something out of place helps everyone on the block. Criminal justice expert and SafeWise advisor Dr. Ben Stickle says neighbors working together can make a big difference, especially with crimes like package theft. He also recommends filing a police report, even though odds of recovering goods swiped off the porch are low.'));

    return securityTips;
  }

  static void initializeIncidenceReportList() {
    IncidenceReport incidenceReport = IncidenceReport(
        "Burglary Case",
        DateTime(2022, 10, 2, 16, 40),
        "Lau Jing En",
        FirebaseAuth.instance.currentUser!.uid,
        "Someone broke into my house yesterday. All of my valuables are gone. Already reported to police but I would need help identifying any suspicious people that came near my house. Thanks!",
        "3, jalan usj 4/2f",
        2);
    incidenceReport.imageUrl = "Image/robbery.jpg";
    incidenceReportList.add(incidenceReport);
    incidenceReport = IncidenceReport(
        "Suspicious Vehicle",
        DateTime(2022, 10, 2, 12, 40),
        "Zoe Tey Yixuan",
        FirebaseAuth.instance.currentUser!.uid,
        "A roughly 6 feet Chinese looking guy driving a motor robbed my bag. The motor driver was armed with a knife and injured my hand.",
        "3, jalan usj 4/2f",
        2);
    incidenceReport.imageUrl = "Image/car.jpg";
    incidenceReportList.add(incidenceReport);
    incidenceReport = IncidenceReport(
        "Stray dogs",
        DateTime(2022, 9, 27, 12, 40),
        "Zoe Tey Yixuan",
        FirebaseAuth.instance.currentUser!.uid,
        "There have been some furious looking stray dogs wandering the streets and they have tried to bite me, please be careful",
        "3, jalan usj 5/2s",
        1);
    incidenceReport.imageUrl = "Image/dog.jpg";
    incidenceReportList.add(incidenceReport);
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

  // static List<String> initializeVehiclePlates() {
  //   vehiclePlates.add("WPA2012");
  //   vehiclePlates.add("EPW2457");
  //   vehiclePlates.add("QOG4962");
  //   vehiclePlates.add("PEJ3353");
  //   vehiclePlates.add("GGO2315");
  //   return vehiclePlates;
  // }

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

  static void initializeEmergencyContacts() {
    emergencyContactlist.add(Contact("adam", "012-32581242"));
    emergencyContactlist.add(Contact("Mom", "016-54541342"));
  }

  static void initializeReportStatus() {
    reportStatusList.add(ReportStatus("0001", "RE: Theft issue", 0, ''));
    reportStatusList.add(ReportStatus("0002", "RE: Suspicious vehicle WOE8237",
        2, 'The vehicle is indeed suspicious'));
    reportStatusList
        .add(ReportStatus("0003", "RE: Suspicious vehicle WHE2325", 1, ''));
  }

  static void initializeRegisteredVehicles() {
    registeredVehiclelist
        .add(Vehicle("WPA2012", DateTime(2019, 6, 11, 13, 14, 13), 2));
    registeredVehiclelist
        .add(Vehicle("EPW2457", DateTime(2021, 1, 1, 13, 5, 10), 1));
    registeredVehiclelist
        .add(Vehicle("QOG4962", DateTime(2020, 7, 17, 16, 10, 10), 2));
  }

  static List<CommunityEvent> initializeCommunityEvents() {
    CommunityEvent communityEvent = CommunityEvent(
        "Resident Association",
        "Anytime Gym",
        "A soft launch opening gym nearby in Taipan Business Center, feel free to join us these month to enjoy the promotion.",
        DateTime(2021, 4, 10, 12, 10, 10));
    communityEvent.imageUrl = 'Image/gym.jpeg';
    communityEvent.address = " 5, Jalan USJ 7/5A";
    communityEvent.isFromLocal = false;
    communityEventList.add(communityEvent);
    communityEvent = CommunityEvent(
        "Resident Association",
        "FOCK SING RESTAURAN",
        "Are you hungry now? Come let’s go to your nearest restaurant to enjoy the CHEAPEST and DELICIOUS FOOD in the town.",
        DateTime(2020, 5, 12, 12, 10, 10));
    communityEvent.imageUrl = 'Image/restoran.jpeg';
    communityEvent.address = "8, Jalan USJ 7/6A";
    communityEvent.isFromLocal = false;
    communityEventList.add(communityEvent);
    communityEvent = CommunityEvent(
        "Resident Association",
        "Fresh Supermarket",
        "This month has a 30 percent promotion when you spent over RM100.",
        DateTime(2021, 4, 15, 12, 10, 10));
    communityEvent.imageUrl = 'Image/supermarket.jpeg';
    communityEvent.address = "13, Jalan USJ 7/5A";
    communityEvent.isFromLocal = false;
    communityEventList.add(communityEvent);
    communityEvent = CommunityEvent(
        "Resident Association",
        "Lavana 2 Badminton Center",
        "Stop playing phone now!! Let’s gather your friend and play badminton!!",
        DateTime(2021, 4, 15, 12, 10, 10));
    communityEvent.imageUrl = 'Image/court.jpeg';
    communityEvent.address = "34, Jalan USJ 7/3a";
    communityEvent.isFromLocal = false;
    communityEventList.add(communityEvent);

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
