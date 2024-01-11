import 'package:aplikasi_kesehatan_mental_anak_remaja/get_x/repository/music_repository.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/models/Music.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';

class MusicController extends GetxController {
  static MusicController get instance => Get.find();

  late AudioPlayer audioPlayer;

  RxBool isPlaying = RxBool(false);

  Rx<Duration> duration = Rx<Duration>(Duration(seconds: 0));
  Rx<Duration> position = Rx<Duration>(Duration(seconds: 0));

  RxString urlAudio = RxString("");

  void setUrlAudio(String url) {
    urlAudio.value = url;
    onInit();
  }

  void slider(double value) {
    audioPlayer.seek(Duration(seconds: value.toInt()));
    audioPlayer.resume();
  }

  void _initializePlayer() {
    audioPlayer = AudioPlayer();
    audioPlayer.onPlayerStateChanged.listen((event) {
      if (event == PlayerState.playing) {
        isPlaying.value = true;
      } else if (event == PlayerState.paused ||
          event == PlayerState.stopped ||
          event == PlayerState.completed) {
        isPlaying.value = false;
      }
      update();
    });

    audioPlayer.onDurationChanged.listen((event) {
      duration.value = event;
      update();
    });

    audioPlayer.onPositionChanged.listen((event) {
      position.value = event;
      update();
    });
  }

  String formatTime(int seconds) {
    return '${(Duration(seconds: seconds))}'.split('.')[0].padLeft(8, '0');
  }

  Future<void> onClickEvent() async {
    isPlaying.value
        ? await audioPlayer.pause()
        : await audioPlayer.play(UrlSource(urlAudio.value));
  }

  @override
  void onInit() {
    super.onInit();
    _initializePlayer();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    isPlaying.value = false;
    duration.value = Duration.zero;
    position.value = Duration.zero;
    urlAudio.value = "";
    audioPlayer.dispose();
  }

  final musicRepositoryController = Get.put(MusicRepositoryController());

  RxString musicName = RxString("");

  void setSearch(String value) {
    musicName.value = value;
    update();
  }

  Stream<List<Music>> searchMusic() => musicRepositoryController.searchMusic(musicName.value);

  Stream<List<Music>> getAllMusic() => musicRepositoryController.getAllMusic();
}
