import 'package:aplikasi_kesehatan_mental_anak_remaja/get_x/controllers/audio_controller.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/models/music.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class MusicScreen extends StatelessWidget {
  const MusicScreen(this.music, {super.key});
  
  final Music music;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MusicController>(builder: (controller) {
      return WillPopScope(
          onWillPop: () async {
            await controller.disposeAudioPlayer();
            return true;
          },
          child: Scaffold(
              body: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        music.musicCover != null || music.musicCover != ""
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(
                                  music.musicCover ?? "https://img.freepik.com/free-vector/realistic-music-record-label-disk-mockup_1017-33906.jpg",
                                  width: double.infinity,
                                  height: 350,
                                  fit: BoxFit.cover,
                                  errorBuilder: (BuildContext context,
                                      Object exception,
                                      StackTrace? stackTrace) {
                                    return Center(
                                      child: Image.asset(
                                          "assets/images/default-cover-music.jpg"),
                                    );
                                  },
                                ),
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Text(music.musicName!),
                              ),
                        const SizedBox(height: 10),
                        Text(music.musicName.toString()),
                        const SizedBox(height: 10),
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(controller.formatTime(
                                      controller.position.value.inSeconds)),
                                  Text(controller.formatTime(
                                      (controller.duration.value -
                                              controller.position.value)
                                          .inSeconds))
                                ])),
                        Slider(
                          value: controller.position.value.inSeconds.toDouble(),
                          min: 0.0,
                          max: controller.duration.value.inSeconds.toDouble(),
                          onChanged: (value) async {
                            controller.slider(value);
                          },
                        ),
                        CircleAvatar(
                          radius: 35,
                          child: IconButton(
                            icon: Icon(controller.isPlaying.value
                                ? Icons.pause
                                : Icons.play_arrow),
                            onPressed: () async {
                              await controller.onClickEvent();
                            },
                          ),
                        )
                      ]))));
    });
  }
}
