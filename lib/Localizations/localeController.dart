import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:praktid_flutter/main.dart';

class LocaleController {
  Locale initlanguage = sharedpref!.getString("lang") == null? Get.deviceLocale!: Locale(sharedpref!.getString("lang")!);
  

  void changelang(String lang) {
    Locale locale = Locale(lang);
    sharedpref?.setString("lang", lang);
    Get.updateLocale(locale);
  }
}
