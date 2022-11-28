import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:praktid_flutter/Localizations/local.dart';
import 'package:praktid_flutter/Localizations/localeController.dart';
import 'package:praktid_flutter/controller/authcontroller.dart';
import 'package:praktid_flutter/theme/theme.dart';

import 'package:praktid_flutter/view/login.dart';
import 'package:praktid_flutter/view/mainpage.dart';
import 'package:praktid_flutter/view/register.dart';
import 'package:praktid_flutter/utils/mybindings.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? sharedpref;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  sharedpref = await SharedPreferences.getInstance();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    LocaleController controller = Get.put(LocaleController());
    bool? theme = sharedpref!.getBool("theme");
    return GetMaterialApp(
        title: 'PrakTID',
        locale: controller.initlanguage,
        fallbackLocale:const Locale("en"),
        translations: MyLocale(),
        initialBinding: MyBinding(),
        theme: theme == true ? Themes.customDarkTheme : Themes.customLightTheme,
        initialRoute: "/",
        getPages: [
          GetPage(
            name: "/",
            page: () => LoginPage(),
          ),
          GetPage(
            name: "/Register",
            page: () => RegisterPage(),
          ),
          GetPage(
            name: "/main",
            page: () => Mainpage(),
          ),
        ]);
  }
}
