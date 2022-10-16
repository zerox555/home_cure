import 'package:cloud_firestore/cloud_firestore.dart';


class DatabaseService {
  final String uid;
  DatabaseService(this.uid);
  //collection reference
  final CollectionReference locationCollection =
      FirebaseFirestore.instance.collection('location');

  Future updateUserData(String locationName, int timeSpent) async {
    return await locationCollection
        .doc(uid)
        .set({'locationName': locationName, 'timeSpent': timeSpent});
  }

}
