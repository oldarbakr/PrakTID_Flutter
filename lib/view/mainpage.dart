import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:praktid_flutter/controller/authcontroller.dart';
import 'package:praktid_flutter/controller/mainController.dart';

class Mainpage extends GetWidget<AuthController> {
  Mainpage({super.key});
  final MainController pagecontroller = Get.find();
  // final MainController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        drawer: const Drawer(),
        body: GetBuilder<MainController>(builder: (pagecontroller) {
          return Column(
            children: [
              ElevatedButton(
                  onPressed: () {
                    controller.signout();
                    pagecontroller.test();
                  },
                  child: const Text("logout")),
                   ElevatedButton(
                  onPressed: () {
                  
                    pagecontroller.test();
                  },
                  child: const Text("test"))
            ],
          );
        }));
  }
}
