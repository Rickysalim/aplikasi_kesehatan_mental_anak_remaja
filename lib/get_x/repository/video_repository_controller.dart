import 'dart:io';

import 'package:aplikasi_kesehatan_mental_anak_remaja/models/Video.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VideoRepositoryController extends GetxController {
  static VideoRepositoryController get instance => Get.find();

  final videoRepo = FirebaseFirestore.instance.collection('Video');

  final videoRepoWithId = FirebaseFirestore.instance.collection('Video').doc();

Stream<List<Video>> searchVideo(String videoTitle) {
  if (videoTitle.isEmpty) {
    return videoRepo
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => Video.fromSnapshot(doc)).toList());
  } else {
    return videoRepo
        .snapshots()
        .map((snapshot) => snapshot.docs
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
          Get.snackbar(
              "Kesalahan", "Terjadi Kesalahan saat menghapus video: $e",
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.red,
              colorText: Colors.white);
        });
        await Future.forEach(oldImageRef.items, (Reference ref) async {
          await ref.delete();
        }).whenComplete(() => {}).catchError((e) {
          Get.snackbar(
              "Kesalahan", "Terjadi Kesalahan saat menghapus gambar: $e",
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.red,
              colorText: Colors.white);
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
        Get.snackbar("Berhasil", "Berhasil memperbaharui video",
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.green,
            colorText: Colors.black);
      }).catchError((e) {
        Get.snackbar("Kesalahan", "Terjadi Kesalahan saat menghapus data: $e",
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white);
      });
    } catch (e) {
      Get.snackbar("Kesalahan", "Terjadi Kesalahan saat menghapus data: $e",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  Future<void> deleteVideo(String id) async {
    final videoRef = FirebaseStorage.instance.ref('uploads/videos/${id}');
    final imageRef = FirebaseStorage.instance.ref('uploads/images/${id}');
    try {
      ListResult oldVideoRef = await videoRef.listAll();
      ListResult oldImageRef = await imageRef.listAll();

      await Future.forEach(oldVideoRef.items, (Reference ref) async {
        await ref.delete();
      }).whenComplete(() => {}).catchError((e) {
        Get.snackbar("Kesalahan", "Terjadi Kesalahan saat menghapus video: $e",
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white);
      });
      await Future.forEach(oldImageRef.items, (Reference ref) async {
        await ref.delete();
      }).whenComplete(() => {}).catchError((e) {
        Get.snackbar("Kesalahan", "Terjadi Kesalahan saat menghapus gambar: $e",
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white);
      });

      await videoRepo.doc(id).delete().whenComplete(() {
        Get.snackbar("Berhasil", "Berhasil menghapus video",
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.green,
            colorText: Colors.black);
      }).catchError((e) {
        Get.snackbar("Kesalahan", "Terjadi Kesalahan saat menghapus data: $e",
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white);
      });
    } catch (e) {
      Get.snackbar("Kesalahan", "Terjadi Kesalahan saat menghapus data: $e",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  Future<void> uploadVideo(Map<String, dynamic> data) async {
    try {
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
        Get.snackbar("Berhasil", "Berhasil Menambah Data Video",
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.green,
            colorText: Colors.black);
      }).catchError((e) {
        Get.snackbar("Kesalahan", "Terjadi Kesalahan saat menyimpan data: $e",
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white);
      });
    } on FirebaseException catch (e) {
      Get.snackbar("Kesalahan", "Terjadi Kesalahan saat menyimpan data: $e",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  Stream<List<Video>> getAllVideo() => videoRepo
      .snapshots()
      .map((e) => e.docs.map((e) => Video.fromSnapshot(e)).toList());
}
