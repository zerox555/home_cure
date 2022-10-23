import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:home_cure/models/EntryEntity.dart';
import 'package:home_cure/models/incidence_report.dart';
import 'package:home_cure/models/patrol_route.dart';
import 'package:home_cure/models/vehicle.dart';
import 'package:home_cure/screens/home/house_patrol.dart';

import '../models/suspiciousEventReport.dart';
import '../models/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService(this.uid);
  //collection reference
  CollectionReference? getSelectedCollection(String collectionName) {
    final CollectionReference foundCollection =
        FirebaseFirestore.instance.collection(collectionName);
    return foundCollection;
  }

  Stream<QuerySnapshot> patrolStream() {
    return FirebaseFirestore.instance
        .collection("patrolRoute")
        .where('routeName', isEqualTo: "Guard usj3/4b")
        .snapshots();
  }

  Future<PatrolRoute> getPatrolRoute() async {
    QuerySnapshot querySnapshot = await getSelectedCollection("patrolRoute")!
        .where('routeName', isEqualTo: "Guard usj3/4b")
        .get();
    var allData = querySnapshot.docs;
    PatrolRoute patrolRoute = PatrolRoute('', []);
    List<Map<String, dynamic>> patrolPoints = [];
    if (allData.isNotEmpty) {
      var element = allData[0];
      // print(element['patrolPoints'].runtimeType);
      // print(element['patrolPoints']);
      var points = element['patrolPoints'] as List<dynamic>;
      points.forEach((element) {
        Map<String, dynamic> pointMap = {
          'isPassed': element['isPassed'],
          'address': element['address'],
          'cordsOnMap': {'lng': element['cordsOnMap']['lng'], 'lat': element['cordsOnMap']['lat']}
        };
        patrolPoints.add(pointMap);
      });

      patrolRoute = PatrolRoute(element['routeName'],patrolPoints);
    }
    return patrolRoute;
  }

  Future updateAppUserData(
      AppUser appUser, CollectionReference? collection) async {
    if (collection == null) {
      print("nothign happened");
    } else {
      await collection.doc(uid).set({
        'appUserName': appUser.name,
        'age': appUser.age,
        'gender': appUser.gender,
        'email': appUser.email,
        'address': appUser.address,
        'phoneNo': appUser.phoneNo,
        'emergencyContacts': appUser.emergencyContacts,
        'registeredVehicles': appUser.registeredVehicles
      });
      for (int i = 0; i < appUser.registeredVehicles!.length; i++) {
        await addVehiclesToAllVehicles(
            appUser.registeredVehicles![i] as Map<String, dynamic>,
            getSelectedCollection('allVehicles'));
      }
    }
  }

  Future addEntryEntityData(
      EntryEntity entryEntity, CollectionReference? collection) async {
    if (collection == null) {
      print("nothign happened");
    } else {
      await collection.doc().set({
        'userId': entryEntity.userId,
        'timeOfReg': entryEntity.timeOfReg,
        'timeOfEntryStart': entryEntity.timeOfEntryStart,
        'timeOfEntryEnd': entryEntity.timeOfEntryEnd,
        'vehicle': entryEntity.vehicle,
        'personName': entryEntity.personName,
        'reasonOfVisit': entryEntity.reasonOfVisit
      });
      return await addVehiclesToAllVehicles(
          entryEntity.vehicle, getSelectedCollection('allVehicles'));
    }
  }

  Future addSuspiciousEvent(SuspiciousEventReport suspiciousEventReport,
      CollectionReference? collection) async {
    if (collection == null) {
      print("nothign happened");
    } else {
      await collection.doc().set({
        'address': suspiciousEventReport.address,
        'description': suspiciousEventReport.description,
        'vehicle': suspiciousEventReport.vehicle
      });
    }
  }

  Future<AppUser?> getProfile() async {
    final ref = getSelectedCollection("users")!.doc(uid).withConverter(
        fromFirestore: AppUser.fromFirestore,
        toFirestore: (AppUser appUser, _) => appUser.toFirestore());
    final docSnap = await ref.get();
    final appUserProfile = docSnap.data();
    if (appUserProfile != null) {
      print(appUserProfile);
      print("text");
    } else {
      print("no such user");
    }
    return appUserProfile;
  }

  Future<List<EntryEntity>> getEntryEntities() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot =
        await getSelectedCollection("tempEntry")!.get();
    List<EntryEntity> entryList = [];
    // Get data from docs and convert map to List
    var allData = querySnapshot.docs;
    allData.forEach((element) {
      EntryEntity entryEntity = EntryEntity(
          element['timeOfReg'].toDate(),
          element['timeOfEntryStart'].toDate(),
          element['timeOfEntryEnd'].toDate(),
          Vehicle(
                  element['vehicle']['carPlate'],
                  element['vehicle']['timeOfRef'],
                  element['vehicle']['vehicleType'])
              .toMap(),
          element['personName'],
          element['reasonOfVisit']);
      entryEntity.userId = element['userId'];
      entryList.add(entryEntity);
    });
    return entryList;
  }

  Future addIncidenceReport(
      IncidenceReport incidenceReport, CollectionReference? collection) async {
    if (collection == null) {
      print("nothing happened");
    } else {
      return await collection.doc().set({
        'incidenceTitle': incidenceReport.incidenceTitle,
        'timeOfOccurance': incidenceReport.timeOfOccurance,
        'reporterName': incidenceReport.reporterName,
        'reporterUid': incidenceReport.reporterUid,
        'incidenceDesc': incidenceReport.incidenceDesc,
        'incidenceLocation': incidenceReport.incidenceLocation,
        'imageUrl': incidenceReport.imageUrl,
        'severity': incidenceReport.severity
      });
    }
  }

  Future addHousePatrolRoute(
      PatrolRoute patrolRoute, CollectionReference? collection) async {
    if (collection == null) {
      print('nothing happened');
    } else {
      return await collection.doc().set({
        'routeName': patrolRoute.routeName,
        'patrolPoints': patrolRoute.patrolPointsList
      });
    }
  }

  Future<List<IncidenceReport>> getIncidenceReport() async {
    QuerySnapshot querySnapshot =
        await getSelectedCollection("incidenceReport")!.get();
    List<IncidenceReport> incidenceReportList = [];
    // Get data from docs and convert map to List
    var allData = querySnapshot.docs;
    allData.forEach((element) {
      IncidenceReport incidenceReport = IncidenceReport(
          element['incidenceTitle'],
          element['timeOfOccurance'].toDate(),
          element['reporterName'],
          element['reporterUid'],
          element['incidenceDesc'],
          element['incidenceLocation'],
          element['severity']);
      incidenceReport.imageUrl = element['imageUrl'];
      incidenceReportList.add(incidenceReport);
    });

    return incidenceReportList;
  }

  Future addVehiclesToAllVehicles(
      Map<String, dynamic> vehicle, CollectionReference? collection) async {
    if (collection == null) {
      print("nothing happened");
    } else {
      return await collection.doc().set({
        "carPlate": vehicle['carPlate'],
        "timeOfRef": vehicle['timeOfReg'],
        "vehicleType": vehicle['vehicleType']
      });
    }
  }

  Future getAndCompareVehiclePlates(String vehiclePlate) async {
    //get and make list from
  }
}
