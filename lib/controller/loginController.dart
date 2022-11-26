import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  String email = "";
  String password = "";

  void register(email, password) async {
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
          Get.toNamed("/");
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

  void login(email, password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (credential.user!.emailVerified == true) {
        print(credential);
      } else {
        return Get.defaultDialog(
          title: "Faild to login",
          middleText:
              "email not verified please check your email and try again",
          textConfirm: "ok",
          textCancel: "send email",
          onCancel: (() {
            verification(credential);
          }),
          onConfirm: () {
            Get.back();
          },
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        return Get.defaultDialog(
          title: "Faild",
          middleText: "No user found for that email.",
          textConfirm: "ok",
          onConfirm: () {
            Get.back();
          },
        );
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        return Get.defaultDialog(
          title: "Faild",
          middleText: "Wrong email or password ",
          textConfirm: "ok",
          onConfirm: () {
            Get.back();
          },
        );
      }
    }
  }

  void resetpassword(email) async {
    String textvalue = email;
    return Get.defaultDialog(
      title: "reset password",
      textConfirm: "Send email",
      content: TextFormField(
        initialValue: email,
        validator: ((text) => EmailValidator.validate(text!)
            ? null
            : "Please enter a valid email"),
        decoration: const InputDecoration(
            labelText: "enter your email", border: OutlineInputBorder()),
        onChanged: (text) {
          textvalue = text;
        },
      ),
      onCancel: () {},
      onConfirm: () async {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: textvalue);
        Get.back();
        return Get.defaultDialog(
            title: "success",
            textCancel: "ok",
            middleText: "email has been send check your email",
            onCancel: () {},);
            
      },
    );
  }
}
