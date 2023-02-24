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
  late BetterPlayerController _betterPlayerController;
  @override
  void initState() {
    super.initState();
    // _controller.play();
    _initplayer();
  }

  void _initplayer() async {
    BetterPlayerConfiguration betterPlayerConfiguration =
        const BetterPlayerConfiguration(
          autoPlay: true,
          autoDispose: true,
          controlsConfiguration: BetterPlayerControlsConfiguration(enableQualities: false,enableSubtitles: false,enableAudioTracks: false,playerTheme: BetterPlayerTheme.cupertino),
         
    );
    BetterPlayerDataSource betterPlayerDataSource =
        BetterPlayerDataSource(BetterPlayerDataSourceType.network, widget.url,
            cacheConfiguration: const BetterPlayerCacheConfiguration(
              useCache: true,
              preCacheSize: 10 * 1024 * 1024,
              maxCacheSize: 10 * 1024 * 1024,
              maxCacheFileSize: 10 * 1024 * 1024,
            ));
    
    _betterPlayerController = BetterPlayerController(betterPlayerConfiguration,
        betterPlayerDataSource: betterPlayerDataSource);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return 
      // Scaffold(
       Scaffold(
        appBar: AppBar(),
        body: GetBuilder<Vodcontroller>(
          builder: (controller) {
            return Column(
              children: [
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: BetterPlayer(
                    controller: _betterPlayerController,
                  ),
                ),
              ],
            );
          }
        ),
      );
    
  }

  @override
  void dispose() {
    super.dispose();
  }
}
