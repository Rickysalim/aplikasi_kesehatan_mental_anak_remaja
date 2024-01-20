import 'package:aplikasi_kesehatan_mental_anak_remaja/get_x/repository/video_repository_controller.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/models/video.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';

class VideoAdminController extends GetxController {
  static VideoAdminController get instance => Get.find();

  final Rx<GlobalKey<FormState>> formKey =
      Rx<GlobalKey<FormState>>(GlobalKey<FormState>());

  Rx<PlatformFile?> imageFile = Rx<PlatformFile?>(null);
  Rx<PlatformFile?> videoFile = Rx<PlatformFile?>(null);

  Rx<TextEditingController> titleController =
      Rx<TextEditingController>(TextEditingController());
  Rx<TextEditingController> descriptionController =
      Rx<TextEditingController>(TextEditingController());

  RxMap<String, dynamic> dataVideoRequest = RxMap({
    "video_id": "",
    "video_title": "",
    "video_description": "",
    "video_url": "",
    "video_caption_url": ""
  });

  RxBool setEditVideo = RxBool(false);

  void clearImageAndVideo() {
    imageFile.value = null;
    videoFile.value = null;
    update();
  }

  @override
  void onClose() {
    super.onClose();
    clearAllData();
  }

  void clearAllData() {
    titleController.value.text = "";
    descriptionController.value.text = "";
    videoFile.value = null;
    imageFile.value = null;
    setEditVideo.value = false;
  }

  void resetData() {
     formKey.value.currentState!.reset();
     clearAllData();
     update();
  }


  Future<void> pickImage() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null) {
      imageFile.value = result.files.first;
    }
    update();
  }

  Future<void> pickVideo() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.video);

    if (result != null) {
      videoFile.value = result.files.first;
    }
    update();
  }

  final videoRepositoryController = Get.put(VideoRepositoryController());

  void setIsEditVideo(Video video) {
    setEditVideo.value = true;

    titleController.value.text = video.videoTitle!;
    descriptionController.value.text = video.videoDescription!;

    dataVideoRequest.value = {
      "video_id": video.videoId,
      "video_title": video.videoTitle,
      "video_description": video.videoDescription,
      "video_url": videoFile.value,
      "video_caption_url": imageFile.value
    };

    update();
  }

  Future<void> editVideo() async {
    dataVideoRequest["video_title"] = titleController.value.text;
    dataVideoRequest["video_description"] = descriptionController.value.text;
    dataVideoRequest["video_url"] = videoFile.value;
    dataVideoRequest["video_caption_url"] = imageFile.value;
    await videoRepositoryController
        .editVideo(dataVideoRequest)
        .whenComplete(() {
      setEditVideo.value = false;
      update();
    });
  }

  Future<void> uploadVideo() async {
    dataVideoRequest.value = {
      "video_id": "",
      "video_title": titleController.value.text,
      "video_description": descriptionController.value.text,
      "video_url": videoFile.value,
      "video_caption_url": imageFile.value
    };
    await videoRepositoryController.uploadVideo(dataVideoRequest);
  }

  Future<void> deleteVideo(String id) async {
    await videoRepositoryController.deleteVideo(id);
  }
}
