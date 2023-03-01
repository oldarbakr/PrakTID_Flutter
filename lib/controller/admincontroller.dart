import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:praktid_flutter/controller/authcontroller.dart';
import 'package:file_picker/file_picker.dart';

class AdminController extends GetxController {
  AuthController authcontroller = Get.find();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<List<File>?> pickVideo() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
    );

    if (result != null) {
      List<File> files = result.paths.map((path) => File(path!)).toList();
      return files;
    } else {
      return null;
    }
  }

  void uploadVideoAndSaveUrlToFirestore(File videoFile) async {
    // Create a storage reference to the video file
    String fileName = videoFile.path.split("/").last;
    Reference storageRef =
        FirebaseStorage.instance.ref().child("gifs/$fileName");

    // Upload the video file to Firebase Storage
    UploadTask uploadTask = storageRef.putFile(videoFile);
    TaskSnapshot taskSnapshot = await uploadTask;
    print("Video uploaded successfully");

    // Get the download URL of the video file
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();

    // Save the download URL to Firestore
    String? token = authcontroller.user.value?.uid;
    CollectionReference gifsDocRef = firestore.collection("gifs");
    await gifsDocRef.doc("chapter_1").set(
        {"lesson_2":{"url": downloadUrl, "meaning": "meaning11", "file": fileName}},
        SetOptions(merge: true));
    print("Video download URL saved to Firestore");
  }

  void uploadVideo() async {
    List<File>? videoFiles = await pickVideo();
    if (videoFiles != null) {
      for (File file in videoFiles) {
        uploadVideoAndSaveUrlToFirestore(file);
      }
    }
  }
}
