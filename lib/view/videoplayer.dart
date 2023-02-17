import 'package:flutter/material.dart';
import 'package:praktid_flutter/controller/vodcontroller.dart';
import 'package:get/get.dart';
import 'package:better_player/better_player.dart';
/// Stateful widget to fetch and then display video content.
class VideoApp extends StatefulWidget {
  Vodcontroller vodcontroller = Get.find();
  final String url;
  VideoApp({Key? key, required this.url}) : super(key: key);

  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {


  @override
  void initState() {
    super.initState();
    // _controller.play();
    _initplayer();
  }

  void _initplayer() async {
    
    
    // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
    setState(() {});

    
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Vodcontroller>(
      builder: (controller) {
        return MaterialApp(
          title: 'Video Demo',
          home: Scaffold(
            body: Center(
              child: BetterPlayer.network(widget.url,betterPlayerConfiguration: const BetterPlayerConfiguration(aspectRatio: 16/9),),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    
    super.dispose();
  }
}
