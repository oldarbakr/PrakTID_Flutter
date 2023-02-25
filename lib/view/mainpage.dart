import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:praktid_flutter/Localizations/localeController.dart';
import 'package:praktid_flutter/controller/authcontroller.dart';
import 'package:praktid_flutter/controller/mainController.dart';

class Mainpage extends StatelessWidget {
  Mainpage({super.key});
  final MainController controller = Get.find();
  final AuthController authcontroller = Get.find();
  final LocaleController localcontroller = Get.find();

  // final MainController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        drawer: Drawer(
          child: GetBuilder<MainController>(
            builder: (controller) {
              return Column(
                children: [
                  const UserAccountsDrawerHeader(
                    accountName: Text('John Doe'),
                    accountEmail: Text('johndoe@example.com'),
                    currentAccountPicture: CircleAvatar(
                      backgroundImage:
                          NetworkImage('https://picsum.photos/250?image=9'),
                    ),
                  ),
                
                       SwitchListTile(
                          value: Get.isDarkMode ? true : false,
                          controlAffinity: ListTileControlAffinity.trailing,
                          title: const Text("Theme"),
                          subtitle: Text(Get.isDarkMode == true ? "dark" : "light"),
                          secondary: const Icon(Icons.flag),
                          onChanged: (val) {
                            controller.changetheme();
                            
                          }),
                    
                 
                  ListTile(
                leading: const Icon(Icons.language),
                title:  Text('Language'.tr),
                trailing: DropdownButton<String>(
                  value: Get.locale?.languageCode,
                  onChanged: (String? newLanguage) {
                    if (newLanguage != null) {
                     
                    }
                  },
                  items:  [
                    DropdownMenuItem<String>(
                      value: 'en',
                      child: const Text('English'),
                      onTap: () {
                        localcontroller.changelang("en");
                      },
                    ),
                    DropdownMenuItem<String>(
                      value: 'tr',
                      child: const Text('Turkish'),
                      onTap:() {
                        localcontroller.changelang("tr");
                      },
                    ),
                    // Add more language options here
                  ],
                ),
              ),
                  Visibility(
                    visible: authcontroller.isadmin,
                    child: ListTile(
                      leading: const Icon(Icons.admin_panel_settings),
                      title: const Text("Admin Page"),
                      onTap: () {
                        Get.toNamed("/admin");
                      },
                    ),
                  ),
                  ListTile(
                      leading: const Icon(Icons.logout),
                      title:  Text("Logout".tr),
                      onTap: () {
                        authcontroller.signout();
                        })

                ],
              );
            }
          ),
        ),
        body: GetBuilder<MainController>(builder: (controller) {
          return ListView.builder(
            itemCount: 6,
            itemBuilder: (BuildContext context, int index) {
              return ElevatedButton(child: Text("yo"),onPressed: () => controller.getchapters(),);
            },
          );
        }));
  }
}
