import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:praktid_flutter/Localizations/localeController.dart';
import 'package:praktid_flutter/controller/admincontroller.dart';
import 'package:praktid_flutter/controller/authcontroller.dart';
import 'package:praktid_flutter/controller/mainController.dart';










class AdminPage extends StatelessWidget {
   AdminPage({super.key});

  

  final AdminController controller = Get.find();
  final AuthController authcontroller = Get.find();
  final LocaleController localcontroller = Get.find();

  @override
  Widget build(BuildContext context) {
      return
        // Scaffold(
      Scaffold(
      appBar: AppBar(),
      body: GetBuilder<AdminController>(builder: (controller) {
        return Column(
          children: [

            ElevatedButton(
                onPressed: () {
                  controller.uploadVideo();
                },
                child: Text("add gif".tr)),
          
          ],
        );
      }),
    );
  }
}