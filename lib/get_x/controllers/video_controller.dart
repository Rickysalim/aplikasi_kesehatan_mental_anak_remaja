import 'dart:async';

import 'package:aplikasi_kesehatan_mental_anak_remaja/get_x/repository/video_repository_controller.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/models/Video.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class VideoController extends GetxController {
  static VideoController get instance => Get.find();

  var urlVideo = "".obs;
  var isVideoPlaying = false.obs;
  var duration = Duration.zero.obs;
  var position = Duration.zero.obs;

  late VideoPlayerController videoPlayerController;
  late Future<void> initializeVideoPlayerFuture;

  void setUrlVideo(String url) {
    urlVideo.value = url;
    onInit();
  }

  void onClickEvent() {
    videoPlayerController.value.isPlaying ? videoPlayerController.pause() : videoPlayerController.play();
  }

  void slider(double value) {
    videoPlayerController.seekTo(Duration(seconds: value.toInt()));
    videoPlayerController.play();
  }

  String formatTimeVideo(int seconds) {
    return '${(Duration(seconds: seconds))}'.split('.')[0].padLeft(8, '0');
  }

  @override
  void onInit() {
    super.onInit();
    videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(urlVideo.value));
    initializeVideoPlayerFuture =
        videoPlayerController.initialize();
    videoPlayerController.addListener(() {
      if(videoPlayerController.value.isInitialized) {
        duration.value = videoPlayerController.value.duration;
        position.value = videoPlayerController.value.position;
        isVideoPlaying.value = videoPlayerController.value.isPlaying;
      }
    });
  }

  @override
  void onClose() {
    videoPlayerController.dispose();
  }

  final videoRepositoryController = Get.put(VideoRepositoryController());

  Stream<List<Video>> getAllVideo() => videoRepositoryController.getAllVideo();
}
