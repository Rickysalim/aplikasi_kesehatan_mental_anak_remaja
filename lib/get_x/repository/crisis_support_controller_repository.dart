import 'package:aplikasi_kesehatan_mental_anak_remaja/models/crisis_support.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class CrisisSupportRepositoryController extends GetxController {
  static CrisisSupportRepositoryController get instance => Get.find();

  final crisisSupportRepo =
      FirebaseFirestore.instance.collection('CrisisSupport');

  Stream<List<CrisisSupport>> getAllCrisisSupport() => crisisSupportRepo
      .snapshots()
      .map((e) => e.docs.map((e) => CrisisSupport.fromSnapshot(e)).toList());
}
