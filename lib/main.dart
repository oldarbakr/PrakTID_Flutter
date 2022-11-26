import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:praktid_flutter/view/login.dart';
import 'package:praktid_flutter/view/register.dart';
import 'package:praktid_flutter/utils/mybindings.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    bool Theme = true;
    return GetMaterialApp(
        title: 'PrakTID',
        initialBinding: MyBinding(),
        theme: Theme == false ? ThemeData.dark() : ThemeData.light(),
        initialRoute: "/",
        getPages: [
          GetPage(
            name: "/",
            page: () =>  LoginPage(),
          ),
          GetPage(
            name: "/Register",
            page: () =>  RegisterPage(),
          ),
        ]);
  }
}
