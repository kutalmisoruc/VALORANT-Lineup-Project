import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_a_18/colorPalette/color.dart';
import 'package:video_player/video_player.dart';

class LineupVideoScreen extends StatefulWidget {
  final String url;//LINEUP VIDEO LINK
  const LineupVideoScreen({Key? key,
  required this.url,
  }) : super(key: key);

  @override
  State<LineupVideoScreen> createState() => _LineupVideoScreenState();
}

class _LineupVideoScreenState extends State<LineupVideoScreen> {
  late VideoPlayerController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = VideoPlayerController.network(widget.url)
    ..addListener(() => setState(() {}),)
    ..setLooping(true)//VIDEO ALWAYS LOOP IF VE DIDNT STOP
    ..initialize().then((_) => controller.play());//AFTER THE LOAD PLAY VIDEO
    controller.value.isInitialized
    ? controller.play()
    : controller.pause();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Video",style: GoogleFonts.robotoMono(fontWeight: FontWeight.bold),),),

      body: Center(
        child: controller.value.isInitialized
          ? Padding(
            padding: const EdgeInsets.only(bottom: 56),//BOTTOM 56 PADDING BECAUSE APPBAR DEFAULT SIZE 56 AND WITH THIS PADDING LOOKS LIKE CENTER
            child: AspectRatio(
                aspectRatio: controller.value.aspectRatio,
                child: VideoPlayer(controller),
              ),
          )
          : Container(),
      ),
         floatingActionButton: FloatingActionButton(
          backgroundColor: colorPalette.watermelon,
          foregroundColor: colorPalette.blackrock,
          onPressed: () {
            setState(() {
              controller.value.isPlaying
                  ? controller.pause()//IF IS PLAYING THEN STOP
                  : controller.play();//IF IS STOP THEN PLAYING
            });
          },
          child: Icon(
            controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
          ),
        ), 
    );
  }
}