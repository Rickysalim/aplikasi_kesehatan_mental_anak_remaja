import 'package:aplikasi_kesehatan_mental_anak_remaja/models/Video.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class VideoRepositoryController extends GetxController {
  static VideoRepositoryController get instance => Get.find();

  final videoRepo =
      FirebaseFirestore.instance.collection('Video');

  Stream<List<Video>> getAllVideo() => videoRepo 
      .snapshots()
      .map((e) => e.docs.map((e) => Video.fromSnapshot(e)).toList()); 
}