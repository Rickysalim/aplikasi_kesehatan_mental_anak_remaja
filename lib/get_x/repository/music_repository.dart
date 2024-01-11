import 'dart:io';

import 'package:aplikasi_kesehatan_mental_anak_remaja/models/Music.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MusicRepositoryController extends GetxController {
  static MusicRepositoryController get instance => Get.find();

  final musicRepo = FirebaseFirestore.instance.collection('Music');

  final musicRepoWithId = FirebaseFirestore.instance.collection('Music').doc();

  Stream<List<Music>> searchMusic(String musicName) {
    if (musicName.isEmpty) {
      return musicRepo
          .snapshots()
          .map((e) => e.docs.map((e) => Music.fromSnapshot(e)).toList());
    } else {
      return musicRepo
        .snapshots()
        .map((snapshot) => snapshot.docs
            .where((doc) {
              String sqlLikePattern = ".*${RegExp.escape(musicName)}.*";
              RegExp pattern = RegExp(sqlLikePattern, caseSensitive: false);
              return pattern.hasMatch(doc["music_name"]);
            })
            .map((doc) => Music.fromSnapshot(doc))
            .toList());
    }
  }

  Future<void> editMusic(Map<String, dynamic> data) async {
    try {
      final audioRef =
          FirebaseStorage.instance.ref('uploads/musics/${data["music_id"]}');
      final imageRef =
          FirebaseStorage.instance.ref('uploads/images/${data["music_id"]}');
      if (data['music_cover'] != "" ||
          data['music_cover'] != null && data['music_url'] != "" ||
          data['music_url'] != null) {
        ListResult oldMusicRef = await FirebaseStorage.instance
            .ref('uploads/musics/${data['music_id']}')
            .listAll();
        ListResult oldImageRef = await FirebaseStorage.instance
            .ref('uploads/images/${data['music_id']}')
            .listAll();

        await Future.forEach(oldMusicRef.items, (Reference ref) async {
          await ref.delete();
        }).whenComplete(() => {}).catchError((e) {
          Get.snackbar(
              "Kesalahan", "Terjadi Kesalahan saat menghapus music: $e",
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
        final newMusicUrl = await audioRef
            .child(data['music_url'].name)
            .putFile(
                File(data['music_url'].path),
                SettableMetadata(
                    contentType: 'audio/${data['music_url'].extension}'));
        final newImageUrl = await imageRef
            .child(data['music_cover'].name)
            .putFile(
                File(data['music_cover'].path),
                SettableMetadata(
                    contentType: 'image/${data['music_cover'].extension}'));

        data['music_url'] = await newMusicUrl.ref.getDownloadURL();
        data['music_cover'] = await newImageUrl.ref.getDownloadURL();
      }

      await musicRepo.doc(data['music_id']).update(data).whenComplete(() {
        Get.snackbar("Berhasil", "Berhasil memperbaharui music",
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.green,
            colorText: Colors.black);
      }).catchError((e) {
        Get.snackbar(
            "Kesalahan", "Terjadi Kesalahan saat memperbaharui data: $e",
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white);
      });
    } catch (e) {
      Get.snackbar("Kesalahan", "Terjadi Kesalahan saat memperbaharui data: $e",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  Future<void> deleteMusic(String id) async {
    try {
      ListResult audioRef =
          await FirebaseStorage.instance.ref('uploads/musics/${id}').listAll();
      ListResult imageRef =
          await FirebaseStorage.instance.ref('uploads/images/${id}').listAll();

      await Future.forEach(audioRef.items, (Reference ref) async {
        await ref.delete();
      }).whenComplete(() => {}).catchError((e) {
        Get.snackbar("Kesalahan", "Terjadi Kesalahan saat menghapus music: $e",
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white);
      });

      await Future.forEach(imageRef.items, (Reference ref) async {
        await ref.delete();
      }).whenComplete(() => {}).catchError((e) {
        Get.snackbar("Kesalahan", "Terjadi Kesalahan saat menghapus gambar: $e",
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white);
      });

      await musicRepo.doc(id).delete().whenComplete(() {
        Get.snackbar("Berhasil", "Berhasil menghapus music",
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

  Future<void> uploadAudio(Map<String, dynamic> data) async {
    try {
      data["music_id"] = musicRepoWithId.id;

      final musicRef =
          FirebaseStorage.instance.ref('uploads/musics/${musicRepoWithId.id}/');
      final imageRef =
          FirebaseStorage.instance.ref('uploads/images/${musicRepoWithId.id}/');

      final musicUrl = await musicRef.child(data['music_url'].name).putFile(
          File(data['music_url'].path),
          SettableMetadata(
              contentType: 'audio/${data['music_url'].extension}'));

      final imageUrl = await imageRef.child(data['music_cover'].name).putFile(
          File(data['music_cover'].path),
          SettableMetadata(
              contentType: 'image/${data['music_cover'].extension}'));

      data['music_url'] = await musicUrl.ref.getDownloadURL();
      data['music_cover'] = await imageUrl.ref.getDownloadURL();

      await musicRepoWithId.set(data).whenComplete(() {
        Get.snackbar("Berhasil", "Berhasil Menambah Data Music",
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

  Stream<List<Music>> getAllMusic() => musicRepo
      .snapshots()
      .map((e) => e.docs.map((e) => Music.fromSnapshot(e)).toList());
}
