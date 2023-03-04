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
import 'package:praktid_flutter/controller/datacontroller.dart';
import 'package:praktid_flutter/model/dataclass.dart';

class AdminController extends GetxController {
  AuthController authcontroller = Get.find();
  DataController dataController = Get.find();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  var chachimage;

  Future<File?> pickVideo() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (result != null) {
      chachimage = File(result.files.single.path!);
      update();
      return chachimage;
    } else {
      // User canceled the picker
      return null;
    }
  }

  Future<bool> uploadVideoAndSaveUrlToFirestore(
      File videoFile, String chapterid, String lessonid, String meaning) async {
    // Create a storage reference to the video file
    try {
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
      await gifsDocRef.doc(chapterid).set({
        lessonid: {"url": downloadUrl, "meaning": meaning, "file": fileName}
      }, SetOptions(merge: true));
      print("Video download URL saved to Firestore");

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> addlesson(String chapterid, String meaning) async {
    dataController.fetchData();
    Chapter chapter = dataController.chapters
        .firstWhere((element) => element.id == chapterid);
    String inputString = chapter.lessons.last.id;
    int currentNumber = int.parse(inputString.split("_")[1]);
    int newNumber = currentNumber + 1;
    String lessonid = "lesson_$newNumber";
    print(lessonid);
    update();
    File imageFile = chachimage;
    if (imageFile != null) {
      bool result = await uploadVideoAndSaveUrlToFirestore(
          imageFile, chapterid, lessonid, meaning);
      if (result == false) {
        return false;
      }

      dataController.fetchData();
      return true;
    }
    return false;
  }

  Future<bool> updatemeaning(
      String chapterid, String lessonid, String meaning) async {
    final docRef = FirebaseFirestore.instance.collection("gifs");
    docRef.doc(chapterid).set({
      lessonid: {"meaning": meaning},
    }, SetOptions(merge: true));

    dataController.fetchData();
    update();
    return true;
  }

  Future<bool> updatelesson(
      String chapterid, String lessonid, String meaning) async {
    File? videoFiles = await pickVideo();

    if (videoFiles != null) {
      bool result = await uploadVideoAndSaveUrlToFirestore(
          videoFiles, chapterid, lessonid, meaning);
      if (result == false) {
        return false;
      }

      dataController.fetchData();
      return true;
    }
    return false;
  }
}
