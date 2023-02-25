import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:praktid_flutter/view/login.dart';
import 'package:praktid_flutter/view/mainpage.dart';

class AuthController extends GetxController {
  String email = "";
  String password = "";
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late DocumentReference userDocRef;
  late Rx<User?> _user;
  Rx<User?> get user => _user;
  late bool isadmin = false;

  @override
  void onInit() async {
    super.onInit();
    _user = Rx<User?>(auth.currentUser);
    String? token = _user.value?.uid;
    userDocRef = firestore.collection("users").doc(token);
    await admincheck();

    // our user would be notified
    _user.bindStream(auth.userChanges());
    //if user login or logout he will be notified from firebase  using bindStream
    // and function ever  taks listener and a fucntion and every time change happens ever function will  work
    //notice that firebase auth always follow user current login state
    ever(_user, _initalScreen);
  }

// navigate to login or main page
  void _initalScreen(User? user) async {
    if (user != null && user.emailVerified == true) {

      Get.offNamed("/main");
    } else {
      Get.offNamed("/");
    }
  }

  void checkinfoinfirebase() async {
    String? token = _user.value?.uid;
    userDocRef.get().then((value) {
      if (value.exists) {
        print("user exist");
      } else {
        firestore
            .collection("users")
            .doc(token)
            .set({}, SetOptions(merge: true)).then((value) {
          print("user aded");
        }).catchError((error) {
          print("Error creating user document: $error");
        });
      }
    });
  }

  void register(String email, String password) async {
    try {
      final credential = await auth.createUserWithEmailAndPassword(
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
      print("An error occured while trying to send email  verification");
      print(e);
    }
  }

  void login(String email, String password) async {
    try {
      final credential = await auth.signInWithEmailAndPassword(
          email: email.trim(), password: password);
      if (credential.user!.emailVerified == true) {
           print(credential);
          _user = Rx<User?>(auth.currentUser);
          String? token = _user.value?.uid;
          userDocRef = firestore.collection("users").doc(token);
           await admincheck();

       
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

  Future<void> admincheck() async {
    IdTokenResult? token = await _user.value?.getIdTokenResult();
    if (token == null) {
      return;
    }
    if (token.claims!.containsKey("admin")) {
      print("is admin");
      isadmin = true;
    } else {
      print("is not admin");
    }
  }

  void resetpassword(String email) async {
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
        try {
          await auth.sendPasswordResetEmail(email: textvalue.trim());
          Get.back();
          return Get.defaultDialog(
            title: "success",
            textCancel: "ok",
            middleText: "email has been send check your email",
            onCancel: () {},
          );
        } catch (e) {
          Get.defaultDialog(
            title: "faild",
            textCancel: "ok",
            middleText: "there is no user record for this email",
            onCancel: () {},
          );
        }
      },
    );
  }

  void signout() async {
    try {
      auth.signOut();
    } catch (e) {
      print(e);
    }
  }
}
