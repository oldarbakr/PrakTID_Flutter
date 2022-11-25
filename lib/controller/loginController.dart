import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  String password = "";
  String email = "";

  void register() async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      verification(credential);
      print(credential);
      return Get.defaultDialog(
        title: "Verification",
        middleText:
            "Please check your email to Verify your account and then use it to sign in",
        textConfirm: "ok",
        onConfirm: () {
          Get.back();
          Get.offAndToNamed("/LoginPage");
        },
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        return Get.defaultDialog(
          title: "Faild",
          middleText: "The password provided is too weak. ",
          textConfirm: "ok",
          onConfirm: () {
            Get.back();
          },
        );
        ;
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        return Get.defaultDialog(
          title: "Faild",
          middleText: "The account already exists for that email.",
          textConfirm: "ok",
          onConfirm: () {
            Get.back();
          },
        );
      }
    } catch (e) {
      print(e);
    }
  }
}

void verification(UserCredential credential) async {
  try {
    if (credential.user!.emailVerified == false) {
      await credential.user!.sendEmailVerification();  
    }
  } catch (e) {
    print("An error occured while trying to send email        verification");
    print(e);
  }
}
