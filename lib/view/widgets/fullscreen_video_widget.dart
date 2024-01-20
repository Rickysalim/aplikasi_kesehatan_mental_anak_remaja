import 'package:aplikasi_kesehatan_mental_anak_remaja/get_x/controllers/video_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:wakelock/wakelock.dart';

class FullScreenVideo extends StatelessWidget {
  const FullScreenVideo(this.controller, {super.key});
  final VideoController controller;

  @override
  Widget build(BuildContext context) {
    return GetX<VideoController>(
        init: controller,
        builder: (controller) {
          return GestureDetector(
              onTap: () => controller.onShowPosition.value =
                  !controller.onShowPosition.value,
              child: Stack(fit: StackFit.expand, children: [
                FutureBuilder(
                    future: controller.initializeVideoPlayerFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return FittedBox(
                            fit: BoxFit.cover,
                            child: SizedBox(
                                width: controller
                                    .videoPlayerController.value.size.width,
                                height: controller
                                    .videoPlayerController.value.size.height,
                                child: AspectRatio(
                                  aspectRatio: controller
                                      .videoPlayerController.value.aspectRatio,
                                  child: VideoPlayer(
                                      controller.videoPlayerController),
                                )));
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
                controller.onShowPosition.value
                    ? Positioned(
                        left: 0.0,
                        right: 0.0,
                        bottom: 0.0,
                        child: Align(
                          alignment: Alignment.center,
                          child: Container(
                            color: const Color.fromRGBO(100, 125, 124, 0.5),
                            child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.red),
                                              onPressed:
                                                  controller.onClickEvent,
                                              child: controller
                                                      .isVideoPlaying.value
                                                  ? const Icon(Icons.pause)
                                                  : const Icon(Icons.play_arrow))),
                                      const SizedBox(width: 5),
                                      Text(
                                          controller.formatTimeVideo(controller
                                              .position.value.inSeconds),
                                          style: const TextStyle(fontSize: 5)),
                                      Text(
                                          controller.formatTimeVideo(
                                              (controller.duration.value -
                                                      controller.position.value)
                                                  .inSeconds),
                                          style: const TextStyle(fontSize: 5)),
                                      Slider(
                                          activeColor: Colors.red,
                                          inactiveColor: const Color.fromARGB(
                                              199, 123, 121, 120),
                                          secondaryActiveColor: Colors.red,
                                          thumbColor: Colors.red,
                                          value: controller
                                              .position.value.inSeconds
                                              .toDouble(),
                                          min: 0.0,
                                          max: controller
                                              .duration.value.inSeconds
                                              .toDouble(),
                                          onChanged: (double newValue) {
                                            controller.slider(newValue);
                                          }),
                                      IconButton(
                                          onPressed: () => controller.setFullScreenVideo(),
                                          icon: const Icon(Icons.fullscreen)),
                                      IconButton(
                                          onPressed: () async {
                                            controller.setLandscapeOrPortrait
                                                    .value =
                                                !controller
                                                    .setLandscapeOrPortrait
                                                    .value;

                                            if (controller
                                                .setLandscapeOrPortrait.value) {
                                              await SystemChrome
                                                  .setPreferredOrientations([
                                                DeviceOrientation.landscapeLeft,
                                                DeviceOrientation.landscapeRight
                                              ]);
                                            } else {
                                              await SystemChrome.setPreferredOrientations(DeviceOrientation.values);
                                            }

                                            await Wakelock.enable();
                                          },
                                          icon: const Icon(Icons.screen_rotation)),
                                    ])),
                          ),
                        ))
                    : const SizedBox.shrink()
              ]));
        });
  }
}
