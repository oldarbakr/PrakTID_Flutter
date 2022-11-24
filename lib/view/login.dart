import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {


    return Scaffold(

      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: const Center(child:  Text("test")),
    );
  }
}