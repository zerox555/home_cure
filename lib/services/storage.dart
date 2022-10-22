import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class Storage{
  final firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;

  Future<void> uploadFile(String filePath,String fileName)async{
    File file = File(filePath);

    try{
      await storage.ref('suspiciousActivity/$fileName').putFile(file);

    } catch(e){
      print(e.toString());
    }
  }

  Future<String> downloadUrl (String imagePath) async {
    String downloadUrl = await storage.ref(imagePath).getDownloadURL();
    return downloadUrl;
  }
}