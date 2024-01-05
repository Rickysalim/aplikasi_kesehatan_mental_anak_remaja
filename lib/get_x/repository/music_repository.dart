
import 'package:aplikasi_kesehatan_mental_anak_remaja/models/Music.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class MusicRepositoryController extends GetxController {
  static MusicRepositoryController get instance => Get.find();

  final musicRepo =
      FirebaseFirestore.instance.collection('Music');

   Stream<List<Music>> getAllMusic() => musicRepo 
      .snapshots()
      .map((e) => e.docs.map((e) => Music.fromSnapshot(e)).toList()); 
}