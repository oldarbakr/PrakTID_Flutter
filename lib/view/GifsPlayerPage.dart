import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:praktid_flutter/controller/GifsController.dart';
import 'package:praktid_flutter/controller/authcontroller.dart';
import 'package:cached_network_image/cached_network_image.dart';
class GifsPlayerPage extends StatelessWidget {
  final String url;
  GifsPlayerPage({Key? key, required this.url}) : super(key: key);

  GifsController controller = Get.find();
  AuthController authcontroller = Get.find();
  @override
  Widget build(BuildContext context) {
    return
        // Scaffold(
        Scaffold(
      appBar: AppBar(),
      body: GetBuilder<GifsController>(builder: (controller) {
        return Column(
          children: [
            SizedBox( 
              height: Get.height*0.4,
              width: Get.width,
              child: CachedNetworkImage(
              imageUrl:url,
              fit: BoxFit.cover,
              placeholder: (context, url) => const Center(
              child: CircularProgressIndicator(),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),)),
          ],
        );
      }),
    );

    
  }
  
}
