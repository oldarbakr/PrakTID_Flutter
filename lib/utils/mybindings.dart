import 'package:flutter/cupertino.dart';
import 'package:praktid_flutter/controller/loginController.dart';

import 'package:get/get.dart';

class MyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() =>LoginController(),fenix: true);
    // Get.lazyPut(() =>ScrollController());
  }
}
