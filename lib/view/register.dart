import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:praktid_flutter/controller/authcontroller.dart';
import 'package:email_validator/email_validator.dart';





class RegisterPage extends StatelessWidget {
   RegisterPage({super.key});

  final AuthController controller = Get.find();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Sign Up"),
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
                            labelText: 'Email',
                          ),
                          validator: (value) => EmailValidator.validate(value!)
                              ? null
                              : "Please enter a valid email",
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
                            labelText: 'Password',
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
                      child: const Text('sign up'),
                      onPressed: () async {
                        var formdata = _formkey.currentState;
                        if (formdata != null && formdata.validate()) {
                          formdata.save();
                          controller.register(
                          controller.email, controller.password);
                        }
                       
                      },
                    )),
                Column(
                  children: [
                    TextButton(
                      onPressed: () {
                        Get.offNamed("/");
                      },
                      child: Text(
                        'sign in',
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
