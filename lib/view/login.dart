import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:praktid_flutter/controller/authcontroller.dart';
import 'package:praktid_flutter/view/register.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final AuthController controller = Get.find();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:  Text("Login".tr),
        ),
        body: GetBuilder<AuthController>(builder: (controller) {
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(20),
                  child: const FlutterLogo(
                    size: 40,
                  ),
                ),
                Form(
                  autovalidateMode: AutovalidateMode.always,
                  key: _formkey,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(90.0),
                            ),
                            labelText: 'Email'.tr,
                          ),
                          validator: (value) => EmailValidator.validate(value!)
                              ? null
                              : "Please enter a valid email".tr,
                          onSaved: (value) {
                            if (value != null) {
                              controller.email = value;
                            }
                          },
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(20),
                        child: TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(90.0),
                            ),
                            labelText: 'Password'.tr,
                          ),
                          onSaved: (value) {
                            if (value != null) {
                              controller.password = value;
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                    height: 80,
                    padding: const EdgeInsets.all(20),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                      ),
                      child:  Text('sign in'.tr),
                      onPressed: () {
                        var formdata = _formkey.currentState;
                        if (formdata != null && formdata.validate()) {
                          formdata.save();
                          controller.login(
                              controller.email, controller.password);
                        }
                      },
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        Get.offNamed("/Register");
                      },
                      child: Text(
                        'Sign Up'.tr,
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ),
                    const SizedBox(
                      width: 60,
                    ),
                    TextButton(
                      onPressed: () {
                        var formdata = _formkey.currentState;
                        if (formdata != null && formdata.validate()) {
                          formdata.save();   
                        }
                        controller.resetpassword(controller.email);
                      },
                      child: Text(
                        'Forgot Password?'.tr,
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }));
  }
}
