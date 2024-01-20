import 'dart:io';

import 'package:aplikasi_kesehatan_mental_anak_remaja/models/video.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class VideoRepositoryController extends GetxController {
  static VideoRepositoryController get instance => Get.find();

  final videoRepo = FirebaseFirestore.instance.collection('Video');

  Stream<List<Video>> searchVideo(String videoTitle) {
    if (videoTitle.isEmpty) {
      return videoRepo.snapshots().map((snapshot) =>
          snapshot.docs.map((doc) => Video.fromSnapshot(doc)).toList());
    } else {
      return videoRepo.snapshots().map((snapshot) => snapshot.docs
          .where((doc) {
            String sqlLikePattern = ".*${RegExp.escape(videoTitle)}.*";
            RegExp pattern = RegExp(sqlLikePattern, caseSensitive: false);
            return pattern.hasMatch(doc["video_title"]);
          })
          .map((doc) => Video.fromSnapshot(doc))
          .toList());
    }
  }

  Future<void> editVideo(Map<String, dynamic> data) async {
    try {
      final videoRef =
          FirebaseStorage.instance.ref('uploads/videos/${data["video_id"]}');
      final imageRef =
          FirebaseStorage.instance.ref('uploads/images/${data["video_id"]}');

      if (data['video_url'] != "" ||
          data['video_url'] != null && data['video_caption_url'] != "" ||
          data['video_caption_url'] != null) {
        ListResult oldVideoRef = await FirebaseStorage.instance
            .ref('uploads/videos/${data['video_id']}')
            .listAll();
        ListResult oldImageRef = await FirebaseStorage.instance
            .ref('uploads/images/${data['video_id']}')
            .listAll();

        await Future.forEach(oldVideoRef.items, (Reference ref) async {
          await ref.delete();
        }).whenComplete(() => {}).catchError((e) {
          Get.snackbar("Error", "Error While Update Video");
        });
        await Future.forEach(oldImageRef.items, (Reference ref) async {
          await ref.delete();
        }).whenComplete(() => {}).catchError((e) {
          Get.snackbar("Error", "Error While Delete Picture");
        });
        final newVideoUrl = await videoRef
            .child(data['video_url'].name)
            .putFile(File(data['video_url'].path),
                SettableMetadata(contentType: 'video/mp4'));
        final newImageUrl = await imageRef
            .child(data['video_caption_url'].name)
            .putFile(
                File(data['video_caption_url'].path),
                SettableMetadata(
                    contentType:
                        'image/${data['video_caption_url'].extension}'));

        data['video_url'] = await newVideoUrl.ref.getDownloadURL();
        data['video_caption_url'] = await newImageUrl.ref.getDownloadURL();
      }

      await videoRepo.doc(data['video_id']).update(data).whenComplete(() {
        Get.snackbar("Success", "Success Update Video");
      }).catchError((e) {
        Get.snackbar("Error", "Error While Update Video");
      });
    } catch (e) {
      Get.snackbar("Error", "Error While Update Video");
    }
  }

  Future<void> deleteVideo(String id) async {
    final videoRef = FirebaseStorage.instance.ref('uploads/videos/$id');
    final imageRef = FirebaseStorage.instance.ref('uploads/images/$id');
    try {
      ListResult oldVideoRef = await videoRef.listAll();
      ListResult oldImageRef = await imageRef.listAll();

      await Future.forEach(oldVideoRef.items, (Reference ref) async {
        await ref.delete();
      }).whenComplete(() => {}).catchError((e) {
        Get.snackbar("Error", "Error While Delete Video");
      });
      await Future.forEach(oldImageRef.items, (Reference ref) async {
        await ref.delete();
      }).whenComplete(() => {}).catchError((e) {
        Get.snackbar("Error", "Error While Update Picture");
      });

      await videoRepo.doc(id).delete().whenComplete(() {
        Get.snackbar("Success", "Success Delete Video");
      }).catchError((e) {
        Get.snackbar("Error", "Error While Delete Video");
      });
    } catch (e) {
      Get.snackbar("Error", "Error While Delete Video");
    }
  }

  Future<void> uploadVideo(Map<String, dynamic> data) async {
    try {
      final videoRepoWithId =
          FirebaseFirestore.instance.collection('Video').doc();
      data["video_id"] = videoRepoWithId.id;

      final videoRef =
          FirebaseStorage.instance.ref('uploads/videos/${videoRepoWithId.id}/');
      final imageRef =
          FirebaseStorage.instance.ref('uploads/images/${videoRepoWithId.id}/');

      final videoUrl = await videoRef.child(data['video_url'].name).putFile(
          File(data['video_url'].path),
          SettableMetadata(contentType: 'video/mp4'));
      final imageUrl = await imageRef
          .child(data['video_caption_url'].name)
          .putFile(
              File(data['video_caption_url'].path),
              SettableMetadata(
                  contentType: 'image/${data['video_caption_url'].extension}'));

      data['video_url'] = await videoUrl.ref.getDownloadURL();
      data['video_caption_url'] = await imageUrl.ref.getDownloadURL();

      await videoRepoWithId.set(data).whenComplete(() {
        Get.snackbar("Success", "Success Add Video");
      }).catchError((e) {
        Get.snackbar("Error", "Error While Add Video");
      });
    } on FirebaseException {
      Get.snackbar("Error", "Error While Add Video");
    }
  }

  Stream<List<Video>> getAllVideo() => videoRepo
      .snapshots()
      .map((e) => e.docs.map((e) => Video.fromSnapshot(e)).toList());
}
