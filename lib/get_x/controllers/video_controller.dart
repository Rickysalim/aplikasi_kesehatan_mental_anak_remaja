import 'package:aplikasi_kesehatan_mental_anak_remaja/get_x/repository/video_repository_controller.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/models/video.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/view/user_screen/video_watch_screen.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:wakelock/wakelock.dart';

class VideoController extends GetxController {
  static VideoController get instance => Get.find();

  RxString urlVideo = RxString("");
  RxBool isVideoPlaying = RxBool(false);
  Rx<Duration> duration = Rx<Duration>(Duration.zero);
  Rx<Duration> position = Rx<Duration>(Duration.zero);
  RxBool  setFullScreen = RxBool(false);
  RxBool setLandscapeOrPortrait = RxBool(false);
  RxBool onShowPosition = RxBool(false);

  late VideoPlayerController videoPlayerController;
  late Future<void> initializeVideoPlayerFuture;

  void setFullScreenVideo() {
    setFullScreen.value = !setFullScreen.value;
    update();
  }

  void setVideo(Video video) {
     videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(video.videoUrl));
    initializeVideoPlayerFuture = videoPlayerController.initialize();
    videoPlayerController.addListener(() {
      if (videoPlayerController.value.hasError) {
        Get.back();
      }
      if (videoPlayerController.value.isInitialized) {
        duration.value = videoPlayerController.value.duration;
        position.value = videoPlayerController.value.position;
        isVideoPlaying.value = videoPlayerController.value.isPlaying;
        Get.to(VideoWatchScreen(video));
      }
    });
    update();
  }

  void onClickEvent() {
    videoPlayerController.value.isPlaying
        ? videoPlayerController.pause()
        : videoPlayerController.play();
    update();
  }

  void slider(double value) {
    videoPlayerController.seekTo(Duration(seconds: value.toInt()));
    videoPlayerController.play();
    update();
  }

  String formatTimeVideo(int seconds) {
    return '${(Duration(seconds: seconds))}'.split('.')[0].padLeft(8, '0');
  }

  Future<void> disposeVideoPlayer() async {
    setFullScreen.value = false;
    onShowPosition.value = false;
    setLandscapeOrPortrait.value = false;
    videoTitle.value = "";
    await videoPlayerController.dispose();
    await SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    await Wakelock.disable();
  }
  

  final videoRepositoryController = Get.put(VideoRepositoryController());

  RxString videoTitle = RxString("");

  void clearSearch() {
    videoTitle.value = "";
    update();
  }

  void setSearch(String value) {
    videoTitle.value = value;
    update();
  }

  Stream<List<Video>> searchVideo() => videoRepositoryController.searchVideo(videoTitle.value);

  Stream<List<Video>> getAllVideo() => videoRepositoryController.getAllVideo();
}
