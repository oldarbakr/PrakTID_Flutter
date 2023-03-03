import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:praktid_flutter/Localizations/localeController.dart';
import 'package:praktid_flutter/controller/authcontroller.dart';
import 'package:praktid_flutter/controller/datacontroller.dart';
import 'package:praktid_flutter/controller/mainController.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:praktid_flutter/model/dataclass.dart';

class Mainpage extends StatelessWidget {
  Mainpage({super.key});
  final MainController controller = Get.find();
  final AuthController authcontroller = Get.find();
  final LocaleController localcontroller = Get.find();
  final DataController dataController = Get.find();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  // final MainController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        drawer: Drawer(
          child: GetBuilder<MainController>(builder: (controller) {
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
                  title: Text('Language'.tr),
                  trailing: DropdownButton<String>(
                    value: Get.locale?.languageCode,
                    onChanged: (String? newLanguage) {
                      if (newLanguage != null) {}
                    },
                    items: [
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
                        onTap: () {
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
                    onTap: () async {
                      List<Chapter> chapters = await dataController.fetchData();
                      Get.toNamed("/admin", arguments: chapters);
                    },
                  ),
                ),
                ListTile(
                    leading: const Icon(Icons.logout),
                    title: Text("Logout".tr),
                    onTap: () {
                      authcontroller.signout();
                    })
              ],
            );
          }),
        ),
        body: GetBuilder<MainController>(builder: (controller) {
          return Obx((){
             if (dataController.chapters==[]) {
                return const Center(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              List<Chapter> items = dataController.chapters;

              return RefreshIndicator(
                onRefresh: () async {
                  dataController.fetchData();
                },
                key: _refreshIndicatorKey,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 210,
                    mainAxisExtent: 210,
                    childAspectRatio: 1 / 2,
                    crossAxisSpacing: 20,
                  ),
                  itemCount: items.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      elevation: 4,
                      margin:const EdgeInsets.all(10),
                      shape: const CircleBorder(),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(100),
                        onTap: () {
                          controller.gotolessons(items, index);
                        },
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                items[index].id,
                                style: const TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                items[index].name,
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
          }
            
            
          );
        }));
  }
}
