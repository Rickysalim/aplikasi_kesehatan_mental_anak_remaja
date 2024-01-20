import 'package:aplikasi_kesehatan_mental_anak_remaja/get_x/controllers/video_controller.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/models/video.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/view/widgets/fullscreen_video_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class VideoWatchScreen extends StatelessWidget {
  static const String id = "video_watch_screen";
  VideoWatchScreen(this.video, {super.key});

  final videoController = Get.put(VideoController());
  final Video? video;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<VideoController>(
        init: videoController,
        builder: (controller) {
          return WillPopScope(
              onWillPop: () async {
                await controller.disposeVideoPlayer();
                return true;
              },
              child: Scaffold(
                  body: Container(
                decoration: const BoxDecoration(
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
                              margin:
                                  const EdgeInsets.only(top: 10, bottom: 10),
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
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                  }),
                            ),
                            const SizedBox(width: 20),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.red),
                                          onPressed: controller.onClickEvent,
                                          child: controller.isVideoPlaying.value
                                              ? const Icon(Icons.pause)
                                              : const Icon(Icons.play_arrow))),
                                  const SizedBox(width: 5),
                                  Obx(() {
                                    return Row(children: [
                                      Text(
                                          controller.formatTimeVideo(controller
                                              .position.value.inSeconds),
                                          style: const TextStyle(fontSize: 5)),
                                      const VerticalDivider(),
                                      Text(
                                          controller.formatTimeVideo(
                                              (controller.duration.value -
                                                      controller.position.value)
                                                  .inSeconds),
                                          style: const TextStyle(fontSize: 5))
                                    ]);
                                  }),
                                  Obx(() {
                                    return Slider(
                                        activeColor: Colors.red,
                                        inactiveColor: const Color.fromARGB(
                                            199, 123, 121, 120),
                                        secondaryActiveColor: Colors.red,
                                        thumbColor: Colors.red,
                                        value: controller
                                            .position.value.inSeconds
                                            .toDouble(),
                                        min: 0.0,
                                        max: controller.duration.value.inSeconds
                                            .toDouble(),
                                        onChanged: (double newValue) {
                                          controller.slider(newValue);
                                        });
                                  }),
                                  IconButton(
                                      onPressed: () =>
                                          controller.setFullScreenVideo(),
                                      icon: const Icon(Icons.fullscreen))
                                ]),
                            Container(
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20)),
                                // color: const Color.fromRGBO(255, 255, 255, 1)
                              ),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                        padding: const EdgeInsets.all(20),
                                        child: Text(video!.videoTitle ?? 'NA',
                                            textAlign: TextAlign.left)),
                                    Padding(
                                        padding: const EdgeInsets.all(20),
                                        child: Text(
                                            video!.videoDescription ?? 'NA',
                                            textAlign: TextAlign.left)),
                                  ]),
                            ),
                          ])
                    : const Align(
                        alignment: Alignment.center,
                        child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Text('404 Not Found',
                                style: TextStyle(
                                    fontFamily: 'MochiyPopOne',
                                    fontSize: 50)))),
              )));
        });
  }
}
