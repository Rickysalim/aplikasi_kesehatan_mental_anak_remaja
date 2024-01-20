import 'package:aplikasi_kesehatan_mental_anak_remaja/get_x/repository/music_repository.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/models/music.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/view/user_screen/music_screen.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';

class MusicController extends GetxController {
  static MusicController get instance => Get.find();

  late AudioPlayer audioPlayer;

  RxBool isPlaying = RxBool(false);

  Rx<Duration> duration = Rx<Duration>(const Duration(seconds: 0));
  Rx<Duration> position = Rx<Duration>(const Duration(seconds: 0));

  RxString urlAudio = RxString("");

  void setAudio(Music music) {
    Get.to(MusicScreen(music));
    urlAudio.value = music.musicUrl!;
    update();
  }

  void slider(double value) {
    audioPlayer.seek(Duration(seconds: value.toInt()));
    audioPlayer.resume();
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

    audioPlayer.onLog.listen(
      (String message) => print(message),
      onError: (Object e, [StackTrace? stackTrace]) => Get.back(),
    );
  }

  Future<void> disposeAudioPlayer() async {
    isPlaying.value = false;
    duration.value = Duration.zero;
    position.value = Duration.zero;
    urlAudio.value = "";
    musicName.value = "";
    await audioPlayer.dispose();
  }

  void onClose() {
    super.onClose();
  }

  final musicRepositoryController = Get.put(MusicRepositoryController());

  RxString musicName = RxString("");

  void clearSearch() {
    musicName.value = "";
    update();
  }

  void setSearch(String value) {
    musicName.value = value;
    update();
  }

  Stream<List<Music>> searchMusic() =>
      musicRepositoryController.searchMusic(musicName.value);

  Stream<List<Music>> getAllMusic() => musicRepositoryController.getAllMusic();
}
