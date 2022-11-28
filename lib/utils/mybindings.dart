import 'package:flutter/cupertino.dart';
import 'package:praktid_flutter/Localizations/localeController.dart';
import 'package:praktid_flutter/controller/authcontroller.dart';

import 'package:get/get.dart';
import 'package:praktid_flutter/controller/mainController.dart';

class MyBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut(() =>AuthController(),fenix: true);
    Get.lazyPut(() => MainController(), fenix: true);
    Get.put<AuthController>(AuthController(),permanent: true);

    // Get.lazyPut(() =>ScrollController());
  }
}
