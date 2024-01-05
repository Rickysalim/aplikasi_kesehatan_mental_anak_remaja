import 'package:aplikasi_kesehatan_mental_anak_remaja/get_x/controllers/audio_controller.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/models/Music.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MusicScreen extends StatelessWidget {
  MusicScreen(this.music);
  Music? music;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MusicController>(builder: (controller) {
      return WillPopScope(
          onWillPop: () async {
            controller.onClose();
            return true;
          },
          child: Scaffold(
              body: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        music!.music_cover != null || music!.music_cover != ""
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(
                                  music!.music_cover.toString(),
                                  width: double.infinity,
                                  height: 350,
                                  fit: BoxFit.cover,
                                  errorBuilder: (BuildContext context,
                                      Object exception,
                                      StackTrace? stackTrace) {
                                    return Center(
                                      child: Image.asset("assets/images/default-cover-music.jpg"),
                                    );
                                  },
                                ),
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Text(music!.music_name.toString()),
                              ),
                        SizedBox(height: 10),
                        Text(music!.music_name.toString()),
                        SizedBox(height: 10),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(controller.formatTime(
                                      controller.position.value.inSeconds)),
                                  Text(controller.formatTime(
                                      controller.duration.value.inSeconds -
                                          controller.position.value.inSeconds))
                                ])),
                        Slider(
                          min: 0,
                          max: controller.duration.value.inSeconds.toDouble(),
                          value: controller.position.value.inSeconds.toDouble(),
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
