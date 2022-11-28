import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:praktid_flutter/Localizations/localeController.dart';
import 'package:praktid_flutter/controller/authcontroller.dart';
import 'package:praktid_flutter/controller/mainController.dart';

class Mainpage extends StatelessWidget {
  Mainpage({super.key});
  final MainController controller = Get.find();
  final AuthController authcontroller = Get.find();
  final LocaleController localcontroller = Get.find();
  // final MainController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        drawer: const Drawer(),
        body: GetBuilder<MainController>(builder: (controller) {
          return Column(
            children: [
              ElevatedButton(
                  onPressed: () {
                    authcontroller.signout();
                  },
                  child: Text("sign out".tr)),
              ElevatedButton(
                  onPressed: () {
                    localcontroller.changelang("en");
                  },
                  child: Text("English".tr)),
              ElevatedButton(
                  onPressed: () {
                    localcontroller.changelang("tr");
                  },
                  child: Text("Turkish".tr)),
              ElevatedButton(
                  onPressed: () {
                    controller.changetheme();
                  },
                  child: Text("theme".tr))
            ],
          );
        }));
  }
}
