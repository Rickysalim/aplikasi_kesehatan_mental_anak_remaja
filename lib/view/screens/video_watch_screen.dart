import 'package:aplikasi_kesehatan_mental_anak_remaja/get_x/controllers/video_controller.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/models/Video.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/view/widgets/fullscreen_video_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class VideoWatchScreen extends StatelessWidget {
  static const String id = "video_watch_screen";
  VideoWatchScreen(this.video);

  final Video? video;

  final videoController = Get.put(VideoController());

  @override
  Widget build(BuildContext context) {
    return GetX<VideoController>(
        init: videoController,
        builder: (controller) {
          return WillPopScope(
              onWillPop: () async {
                if (controller.videoPlayerController.value.isInitialized) {
                  controller.onClose();
                  return true;
                }
                return false;
              },
              child: Scaffold(
                  body: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                      Color.fromRGBO(255, 253, 208, 1),
                      Color.fromRGBO(255, 255, 255, 1),
                    ])),
                child: video != null
                    ? controller.setFullScreen.value
                        ? FullScreenVideo(controller) 
                        : ListView(children: [
                            Container(
                              margin: EdgeInsets.only(top: 10, bottom: 10),
                              width: double.infinity,
                              child: FutureBuilder(
                                  future:
                                      controller.initializeVideoPlayerFuture,
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.done) {
                                      return AspectRatio(
                                        aspectRatio: controller
                                            .videoPlayerController
                                            .value
                                            .aspectRatio,
                                        child: VideoPlayer(
                                            controller.videoPlayerController),
                                      );
                                    } else {
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                  }),
                            ),
                            SizedBox(width: 20),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                      padding: EdgeInsets.all(5),
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.red),
                                          onPressed: controller.onClickEvent,
                                          child: controller.isVideoPlaying.value
                                              ? Icon(Icons.pause)
                                              : Icon(Icons.play_arrow))),
                                  SizedBox(width: 5),
                                  Text(
                                      controller.formatTimeVideo(
                                          controller.position.value.inSeconds),
                                      style: TextStyle(fontSize: 5)),
                                  Text(
                                      controller.formatTimeVideo(
                                          (controller.duration.value -
                                                  controller.position.value)
                                              .inSeconds),
                                      style: TextStyle(fontSize: 5)),
                                  Slider(
                                      activeColor: Colors.red,
                                      inactiveColor:
                                          Color.fromARGB(199, 123, 121, 120),
                                      secondaryActiveColor: Colors.red,
                                      thumbColor: Colors.red,
                                      value: controller.position.value.inSeconds
                                          .toDouble(),
                                      min: 0.0,
                                      max: controller.duration.value.inSeconds
                                          .toDouble(),
                                      onChanged: (double newValue) {
                                        controller.slider(newValue);
                                      }),
                                  IconButton(
                                      onPressed: () =>
                                          controller.setFullScreen.value = true,
                                      icon: Icon(Icons.fullscreen))
                                ]),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20)),
                                // color: const Color.fromRGBO(255, 255, 255, 1)
                              ),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.all(20),
                                        child: Text(video!.video_title ?? 'NA',
                                            textAlign: TextAlign.left)),
                                    Padding(
                                        padding: EdgeInsets.all(20),
                                        child: Text(
                                            video!.video_description ?? 'NA',
                                            textAlign: TextAlign.left)),
                                  ]),
                            ),
                          ])
                    : Align(
                        child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Text('404 Not Found',
                                style: TextStyle(
                                    fontFamily: 'MochiyPopOne', fontSize: 50))),
                        alignment: Alignment.center),
              )));
        });
  }
}
