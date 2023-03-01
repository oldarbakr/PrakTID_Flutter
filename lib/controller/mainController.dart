import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:praktid_flutter/main.dart';
import 'package:praktid_flutter/theme/theme.dart';

import 'authcontroller.dart';

class MainController extends GetxController {
  final AuthController authcontroller = Get.find();

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
  }

  void changetheme() async {
    if (Get.isDarkMode) {
      sharedpref!.setBool("theme", false);
      Get.changeTheme(Themes.customLightTheme);
    } else {
      sharedpref!.setBool("theme", true);
      Get.changeTheme(Themes.customDarkTheme);
    }
    await Future.delayed(const Duration(milliseconds: 200));

    update();
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      getchapters() async {
    final docRef = FirebaseFirestore.instance.collection("gifs");

    var docSnapshot = await docRef.get();
    for (var doc in docSnapshot.docs) {
      final String documentId = doc.id;

      print(
          "-----------------------------------------------------------------------------------------------");
      print(documentId);
      print(
          "-----------------------------------------------------------------------------------------------");

      // Do something with the document ID
    }

    return docSnapshot.docs;
  }

  Future getlessons(chapterid) async {
    try {
      final docRef =
          FirebaseFirestore.instance.collection("gifs").doc(chapterid);

      var docSnapshot = await docRef.get();
      if (docSnapshot == null) {
        print("no items in snapshot");
        return null;
      }
      var items = docSnapshot.data();

      for (var doc in items!["id"]) {
        final String documentId = doc.id;

        print(
            "-----------------------------------------------------------------------------------------------");
        print(documentId);
        print(
            "-----------------------------------------------------------------------------------------------");

        // Do something with the document ID
      }

      return items;
    } catch (e) {
      print("faild to fetch lessons from api $e");
    }
  }
  void gotolessons(items,index){
      // Get.toNamed("/chapter", arguments: items[index].id);
      var myMap = items[index].data();
      myMap.keys
          .where((key) => !key.startsWith("lesson_"))
          .toList()
          .forEach(myMap.remove);
      print(myMap);
      Get.toNamed("/lessons", arguments: myMap);
  }
  Future openGif() async {
    final docRef = FirebaseFirestore.instance
        .collection("gifs")
        .doc("chapter_1")
        .collection("lesson_1")
        .doc("info");

    authcontroller.user;
    var docSnapshot = await docRef.get();
    if (docSnapshot != null) {
      final Map<String, dynamic> data = docSnapshot.data()!;
      String url = data["url"];
      print(
          "-----------------------------------------------------------------------------------------------");
      print(url);
      print(
          "-----------------------------------------------------------------------------------------------");
      Get.toNamed("/gif", arguments: url);
    }
  }

  void uploadvod() {}
}
