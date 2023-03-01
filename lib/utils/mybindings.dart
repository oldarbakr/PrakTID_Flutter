import 'package:flutter/cupertino.dart';
import 'package:praktid_flutter/Localizations/localeController.dart';
import 'package:praktid_flutter/controller/GifsController.dart';
import 'package:praktid_flutter/controller/admincontroller.dart';
import 'package:praktid_flutter/controller/authcontroller.dart';

import 'package:get/get.dart';
import 'package:praktid_flutter/controller/mainController.dart';
import 'package:praktid_flutter/view/AdminPage.dart';


class MyBinding extends Bindings {
  @override
  void dependencies() {
    
    // Get.lazyPut(() =>AuthController(),fenix: true);
    Get.lazyPut(() => MainController(), fenix: true);
    Get.lazyPut(() => AdminController(), fenix: true);
    Get.lazyPut(() => GifsController(), fenix: true);
    Get.put<AuthController>(AuthController(), permanent: true);

    // Get.lazyPut(() =>ScrollController());
  }
}
