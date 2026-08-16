import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';


class StorageService {

  final FirebaseStorage storage =
      FirebaseStorage.instance;


  Future<String> uploadImage(File image) async {

    final String imageName =
    DateTime.now()
        .millisecondsSinceEpoch
        .toString();


    final Reference reference =
    storage
        .ref()
        .child("notes_images/$imageName");


    await reference.putFile(image);


    final String imageUrl =
    await reference.getDownloadURL();


    return imageUrl;
  }
}