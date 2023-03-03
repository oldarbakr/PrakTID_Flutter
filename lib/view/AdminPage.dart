import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:praktid_flutter/Localizations/localeController.dart';
import 'package:praktid_flutter/controller/admincontroller.dart';
import 'package:praktid_flutter/controller/authcontroller.dart';
import 'package:praktid_flutter/controller/datacontroller.dart';
import 'package:praktid_flutter/controller/mainController.dart';
import 'package:praktid_flutter/model/dataclass.dart';

class AdminPage extends StatelessWidget {
  AdminPage({super.key});

  final AdminController controller = Get.find();
  final AuthController authcontroller = Get.find();
  final LocaleController localcontroller = Get.find();
  final DataController datacontroller = Get.find();

  String chapterid = "";
  String meaning = "";
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    List<Chapter> chapters = datacontroller.chapters;

    Dialog addnewlesson = Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0)), //this right here
        child: SingleChildScrollView(
          child: GetBuilder<AdminController>(builder: (context) {
            return SizedBox(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Form(
                  key: formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 50,
                        child: Text(
                          "Add New Lesson",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      SizedBox(
                        width: 200,
                        child: DropdownButtonFormField<String>(
                          items: chapters.map((selectedchapter) {
                            return DropdownMenuItem<String>(
                              value: selectedchapter.id,
                              child: Text(selectedchapter.id),
                            );
                          }).toList(),
                          onChanged: (value) {
                            chapterid = value!;
                          },
                          decoration: const InputDecoration(
                            hintText: 'Select a chapter',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null) {
                              return 'Please select an option'; // This validator will run when the form is submitted and check if an option was selected
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: 200,
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          decoration:
                              const InputDecoration(hintText: "The meaning"),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "please add value";
                            } else {
                              return null;
                            }
                          },
                          onSaved: (vlaue) {
                            meaning = vlaue!;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: 200,
                        height: 200,
                        child: InkWell(
                          onTap: () async {
                            var pickedFile = await controller.pickVideo();
                            if (pickedFile != null) {
                              String fileName = pickedFile.path.split("/").last;
                            }
                          },
                          child: controller.chachimage != null
                              ? Image.file(controller.chachimage!)
                              : const Icon(Icons.image),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0, top: 16.0),
                        child: SizedBox(
                          width: 200,
                          height: 50,
                          child: ElevatedButton.icon(
                              onPressed: () {
                                var formndata = formkey.currentState;
                                if (formndata!.validate()) {
                                  formndata.save();
                                  print("works $chapterid,$meaning");
                                  if (controller.chachimage == null) {
                                    Get.defaultDialog(
                                      title: "empty section",
                                      textCancel: "ok",
                                      middleText: "please select an image",
                                      onCancel: () {},
                                    );
                                  } else {
                                    controller.addlesson(chapterid, meaning);
                                    controller.chachimage = null;

                                    Get.back();
                                  }
                                }
                              },
                              icon: const Icon(Icons.add),
                              label: const Text("Add")),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ));
          }),
        ));

    return
        // Scaffold(
        Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) => addnewlesson);
          },
          label: const Icon(Icons.add)),
      body: GetBuilder<AdminController>(builder: (controller) {
        return Obx(() {
          return ListView.builder(
            itemCount: chapters.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  const Divider(
                    height: 20,
                    thickness: 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        chapters[index].name,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Text(
                        chapters[index].id,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    height: 20,
                    thickness: 2,
                  ), // display the chapter name
                  ListView.builder(
                    shrinkWrap: true, // set shrinkWrap to true
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: chapters[index].lessons.length,
                    itemBuilder: (context, lessonIndex) {
                      return Card(
                        elevation: 8.0,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ExpansionTile(
                                title: Text(
                                  chapters[index].lessons[lessonIndex].meaning,
                                  style: const TextStyle(
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ElevatedButton(
                                        onPressed: () async {
                                          Get.defaultDialog(
                                            content: SizedBox(
                                              width: 200,
                                              child: Form(
                                                key: formkey,
                                                child: TextFormField(
                                                  onSaved: (vlaue) {
                                                    meaning = vlaue!;
                                                  },
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return "please add value";
                                                    } else {
                                                      return null;
                                                    }
                                                  },
                                                  decoration: const InputDecoration(
                                                      hintText:
                                                          "Enter a new meaning"),
                                                ),
                                              ),
                                            ),
                                            onConfirm: () async {
                                              var formdata =
                                                  formkey.currentState;
                                              if (formdata!.validate()) {
                                                formdata.save();
                                                bool uploadsuccess =
                                                    await controller
                                                        .updatemeaning(
                                                            chapters[index].id,
                                                            chapters[index]
                                                                .lessons[
                                                                    lessonIndex]
                                                                .id,
                                                            meaning);
                                                Get.back();

                                                if (uploadsuccess) {
                                                  Get.defaultDialog(
                                                    title: "success",
                                                    textCancel: "ok",
                                                    middleText:
                                                        "Upload completed",
                                                    onCancel: () {},
                                                  );
                                                } else {
                                                  Get.defaultDialog(
                                                    title: "error",
                                                    textCancel: "ok",
                                                    middleText: "Upload failed",
                                                    onCancel: () {},
                                                  );
                                                }
                                              }
                                            },
                                          );
                                        },
                                        child: const Text("change meaning")),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    ElevatedButton(
                                        onPressed: () async {
                                          bool uploadsuccess =
                                              await controller.updatelesson(
                                                  chapters[index].id,
                                                  chapters[index]
                                                      .lessons[lessonIndex]
                                                      .id,
                                                  chapters[index]
                                                      .lessons[lessonIndex]
                                                      .meaning);

                                          if (uploadsuccess) {
                                            Get.defaultDialog(
                                              title: "success",
                                              textCancel: "ok",
                                              middleText: "Upload completed",
                                              onCancel: () {},
                                            );
                                          } else {
                                            Get.defaultDialog(
                                              title: "error",
                                              textCancel: "ok",
                                              middleText: "Upload failed",
                                              onCancel: () {},
                                            );
                                          }
                                        },
                                        child: const Text("Update File")),
                                  ],
                                ),
                                children: [
                                  CachedNetworkImage(
                                    imageUrl: chapters[index]
                                        .lessons[lessonIndex]
                                        .videoUrl,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              );
            },
          );
        });
      }),
    );
  }
}
