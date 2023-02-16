import 'package:flutter/material.dart';
import 'package:praktid_flutter/controller/vodcontroller.dart';
import 'package:video_player/video_player.dart';

import 'package:get/get.dart';

/// Stateful widget to fetch and then display video content.
class VideoApp extends StatefulWidget {
   Vodcontroller vodcontroller = Get.find();
     final String url;
     VideoApp({Key? key, required this.url}) : super(key: key);
  

  @override
  _VideoAppState createState() => _VideoAppState();
  
}

class _VideoAppState extends State<VideoApp> {
  late VideoPlayerController _controller;
 

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        widget.url)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });

      _controller.play();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Vodcontroller>(
      builder: (controller) {
        return MaterialApp(
          title: 'Video Demo',
          home: Scaffold(
            body: Center(
              child: _controller.value.isInitialized
                  ? AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    )
                  : Container(),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                setState(() {
                  _controller.value.isPlaying
                      ? _controller.pause()
                      : _controller.play();
                });
              },
              child: Icon(
                _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
