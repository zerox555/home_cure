import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:home_cure/models/patrol_route.dart';
import 'package:home_cure/shared/constants.dart';

import '../../services/database.dart';
import '../../services/resources.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';


class HomePatrol extends StatefulWidget {
  const HomePatrol({Key? key}) : super(key: key);

  @override
  State<HomePatrol> createState() => _HomePatrolState();
}

class _HomePatrolState extends State<HomePatrol> {
  Completer<GoogleMapController> _controller = Completer();
  static const LatLng sourceLocation = LatLng(3.049870, 101.573301);
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(3.047588, 101.573301),
    zoom: 16.11,
  );
  DatabaseService _dbService =
  DatabaseService(FirebaseAuth.instance.currentUser!.uid);

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  Future<Polyline> _getRoutePolyline(
      {required LatLng start,
        required LatLng finish,
        required Color color,
        required String id,
        int width = 6}) async {
    // Generates every polyline between start and finish
    final polylinePoints = PolylinePoints();
    // Holds each polyline coordinate as Lat and Lng pairs
    final List<LatLng> polylineCoordinates = [];

    final startPoint = PointLatLng(start.latitude, start.longitude);
    final finishPoint = PointLatLng(finish.latitude, finish.longitude);

    final result = await polylinePoints.getRouteBetweenCoordinates(
      google_api_key,
      startPoint,
      finishPoint,
    );
    if (result.points.isNotEmpty) {
      // loop through all PointLatLng points and convert them
      // to a list of LatLng, required by the Polyline
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(
          LatLng(point.latitude, point.longitude),
        );
      });
    }
    final polyline = Polyline(
      polylineId: PolylineId(id),
      color: color,
      points: polylineCoordinates,
      width: width,
    );
    return polyline;
  }

  List<LatLng> polylineCoordinates = [];
  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        google_api_key,
        PointLatLng(3.047588, 101.573301),
        PointLatLng(3.049588, 101.573301));

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng element) {
        polylineCoordinates.add(LatLng(element.latitude, element.longitude));
      });

      setState(() {});
    }
  }

  //function that takes in list of route points and creates a list of polyline to add to widget
  Future<List<Polyline>> getAllPolylineOfRoute(
      List<Map<String, dynamic>> routePointsList) async {
    List<Polyline> polylineList = [];
    // List<Map<String, dynamic>> routePointsList = routeRoute['patrolPoints'];
    var polylineStart;
    var polylineFinish;
    for (int index = 0; index < routePointsList.length - 1; index++) {
      polylineStart = LatLng(routePointsList[index]['cordsOnMap']['lat'],
          routePointsList[index]['cordsOnMap']['lng']);
      polylineFinish = LatLng(routePointsList[index + 1]['cordsOnMap']['lat'],
          routePointsList[index + 1]['cordsOnMap']['lng']);

      polylineList.add(await _getRoutePolyline(
          start: polylineStart,
          finish: polylineFinish,
          color: Colors.blue,
          id: index.toString()));
    }

    print(polylineList);
    return polylineList;
  }

  //function to create markers based on latlng
  Future<List<Marker>> getAllMarkers(
      List<Map<String, dynamic>> routePointsList) async {
    List<Marker> markerList = [];
    // List<Map<String, dynamic>> routePointsList = routeRoute['patrolPoints'];
    var markerLatLng;
    var isChecked;
    print(routePointsList.length);
    for (int index = 0; index < routePointsList.length; index++) {
      markerLatLng = LatLng(routePointsList[index]['cordsOnMap']['lat'],
          routePointsList[index]['cordsOnMap']['lng']);
      isChecked = routePointsList[index]['isPassed'];
      markerList.add(Marker(
        icon: isChecked
            ? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed)
            : BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        markerId: MarkerId(index.toString()),
        position: markerLatLng,
      ));
    }
    return markerList;
  }

  @override
  void initState() {
    getPolyPoints();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
            'House Patrol',
            style: TextStyle(
                fontFamily: 'Inter',
                color: Colors.lightBlue[900],
                fontWeight: FontWeight.bold,
                fontSize: 22)
        ),
        centerTitle: true,
        backgroundColor: Colors.lightBlueAccent[100],

      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("patrolRoute")
              .where('routeName', isEqualTo: "Guard usj3/4b")
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading");
            }

            //converting code here
            var allData = snapshot.data!.docs;
            List<Map<String, dynamic>> patrolPoints = [];
            if (allData.isNotEmpty) {
              var element = allData[0];

              var points = element['patrolPoints'] as List<dynamic>;
              points.forEach((element) {
                Map<String, dynamic> pointMap = {
                  'isPassed': element['isPassed'],
                  'address': element['address'],
                  'cordsOnMap': {
                    'lng': element['cordsOnMap']['lng'],
                    'lat': element['cordsOnMap']['lat']
                  }
                };
                patrolPoints.add(pointMap);
              });
            }
            return FutureBuilder<List<dynamic>>(
                future: Future.wait([
                  //future [0]
                  getAllPolylineOfRoute(patrolPoints),
                  //future [1]
                  getAllMarkers(patrolPoints)
                ]),
                builder: (BuildContext context,
                    AsyncSnapshot<List<dynamic>> snapshotFuture) {
                  if (snapshotFuture.hasData) {
                    //LAYOUT IS HERE
                    return Container(
                      margin: EdgeInsets.fromLTRB(20, 30, 20, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 80,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Your House: ',
                                    style: TextStyle(
                                        fontFamily: 'Inter',
                                        color: Color(0xFF015C92),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16)),
                                SizedBox(height: 10),
                                Text('4, Jalan USJ 5',
                                    style: TextStyle(
                                        fontFamily: 'Inter',
                                        color: Color(0xFF015C92),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20))
                              ],
                            ),
                          ),
                          Container(
                              height: 300,
                              width:500,
                              child: GoogleMap(
                                  mapType: MapType.normal,
                                  initialCameraPosition: _kGooglePlex,
                                  polylines: Set.from(snapshotFuture.data![0]),
                                  markers: Set.from(snapshotFuture.data![1]))
                          ),
                          SizedBox(height: 20),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Nearest Gate Contact: ',
                                    style: TextStyle(
                                        fontFamily: 'Inter',
                                        color: Color(0xFF015C92),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16)),
                                SizedBox(height: 20),
                                Container(
                                  padding: EdgeInsets.all(10.0),
                                  width: 370,
                                  height: 70,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Color(0xFFE0F0FF),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color(0xFFC9D9E8),
                                          spreadRadius: 0,
                                          blurRadius: 16,
                                          offset: Offset(8, 8),
                                        ),
                                        BoxShadow(
                                          color: Color(0xFFFFFFFF),
                                          spreadRadius: 0,
                                          blurRadius: 16,
                                          offset: Offset(-8, -8),
                                        )
                                      ]),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Icon(Icons.door_sliding,
                                          size: 35,
                                          color: Color(0xFF015C92)
                                      ),
                                      SizedBox(width: 10),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('Gate A',
                                              style: TextStyle(
                                                  fontFamily: 'Inter',
                                                  color: Color(0xFF015C92),
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 16)),
                                          Text('Security Supervisor Tom',
                                              style: TextStyle(
                                                  fontFamily: 'Inter',
                                                  color: Color(0xFF015C92),
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16))
                                        ],
                                      ),
                                      SizedBox(width: 40),
                                      IconButton(
                                          onPressed: () async {
                                            FlutterPhoneDirectCaller.callNumber("011234445");
                                          },
                                          icon: Icon(Icons.call,
                                            size: 30,
                                            color: Color(0xFF015C92),))
                                    ],

                                  ),

                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  } else {
                    return Container();
                  }
                });
            ;
          }),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}