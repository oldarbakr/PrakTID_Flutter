import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:praktid_flutter/controller/authcontroller.dart';
import 'package:praktid_flutter/controller/mainController.dart';

class Mainpage extends StatelessWidget {
  Mainpage({super.key});
  final MainController controller = Get.find();
  final AuthController authcontroller = Get.find();
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
                    controller.test();
                  },
                  child: const Text("logout")),
              ElevatedButton(
                  onPressed: () {
                    controller.test();
                  },
                  child: const Text("test"))
            ],
          );
        }));
  }
}
