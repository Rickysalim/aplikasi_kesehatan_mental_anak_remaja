import 'package:aplikasi_kesehatan_mental_anak_remaja/get_x/repository/music_repository.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/models/music.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';

class MusicAdminController extends GetxController {
  static MusicAdminController get instance => Get.find();

  final Rx<GlobalKey<FormState>> formKey =
      Rx<GlobalKey<FormState>>(GlobalKey<FormState>());

  Rx<PlatformFile?> imageFile = Rx<PlatformFile?>(null);
  Rx<PlatformFile?> audioFile = Rx<PlatformFile?>(null);

  Rx<TextEditingController> nameController =
      Rx<TextEditingController>(TextEditingController());

  RxMap<String, dynamic> dataMusicRequest = RxMap(
      {"music_id": "", "music_name": "", "music_url": "", "music_cover": ""});

  RxBool setEditMusic = RxBool(false);

  void clearImageAndAudio() {
    imageFile.value = null;
    audioFile.value = null;
    update();
  }

  void clearAllData() {
    nameController.value.text = "";
    audioFile.value = null;
    imageFile.value = null;
    setEditMusic.value = false;
  }

  void resetData() {
     formKey.value.currentState!.reset();
     clearAllData();
     update();
  }

  @override
  void onClose() {
    super.onClose();
    clearAllData();
  }

  Future<void> pickImage() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null) {
      imageFile.value = result.files.first;
      update();
    }
  }

  Future<void> pickAudio() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.audio);

    if (result != null) {
      audioFile.value = result.files.first;
      update();
    }
  }

  final musicRepositoryController = Get.put(MusicRepositoryController());

  void setIsEditVideo(Music music) {
    setEditMusic.value = true;

    nameController.value.text = music.musicName!;

    dataMusicRequest.value = {
      "music_id": music.musicId,
      "music_name": music.musicName,
      "music_url": audioFile.value,
      "music_cover": imageFile.value,
    };

    update();
  }

  Future<void> editAudio() async {
    dataMusicRequest["music_name"] = nameController.value.text;
    dataMusicRequest["music_url"] = audioFile.value;
    dataMusicRequest["music_cover"] = imageFile.value;
    await musicRepositoryController
        .editMusic(dataMusicRequest)
        .whenComplete(() {
          setEditMusic.value = false;
          update();
        });
  }

  Future<void> uploadAudio() async {
    dataMusicRequest.value = {
      "music_id": "",
      "music_name": nameController.value.text,
      "music_url": audioFile.value,
      "music_cover": imageFile.value,
    };
    await musicRepositoryController.uploadAudio(dataMusicRequest);
  }

  Future<void> deleteAudio(String id) async {
    await musicRepositoryController.deleteMusic(id);
  }
}
