import 'package:flutter/material.dart';
import 'package:praktid_flutter/controller/loginController.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

LoginController controller = Get.find();

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Login"),
        ),
        body: GetBuilder<LoginController>(builder: (controller) {
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
                Container(
                  padding: const EdgeInsets.all(20),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(90.0),
                      ),
                      labelText: 'Email',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(90.0),
                      ),
                      labelText: 'Password',
                    ),
                  ),
                ),
                Container(
                    height: 80,
                    padding: const EdgeInsets.all(20),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                      ),
                      child: const Text('Log In'),
                      onPressed: () {},
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        Get.toNamed("/RegisterPage");
                      },
                      child: Text(
                        'Sign Up',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ),
                    const SizedBox(
                      width: 60,
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Forgot Password?',
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
