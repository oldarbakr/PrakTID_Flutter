import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:praktid_flutter/main.dart';
import 'package:praktid_flutter/theme/theme.dart';

import 'authcontroller.dart';

class MainController extends GetxController {
  final AuthController authcontroller = Get.find();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void changetheme() {
    if (Get.isDarkMode) {
      sharedpref!.setBool("theme", false);
      Get.changeTheme(Themes.customLightTheme);
    } else {
      sharedpref!.setBool("theme", true);
      Get.changeTheme(Themes.customDarkTheme);
    }
  }



  Future openvideo() async {
    final AuthController authcontroller = Get.find();
    final docRef = FirebaseFirestore.instance
        .collection("videos")
        .doc("ch1-harflari")
        .collection("lesson1")
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
        Get.toNamed("/vod",arguments:url );
    }

    
  }
}
