import 'package:aplikasi_kesehatan_mental_anak_remaja/models/Diagnose.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class DiagnoseRepositoryController extends GetxController {
  static DiagnoseRepositoryController get instance => Get.find();

  final diagnoseRepo = FirebaseFirestore.instance.collection('Diagnose');

  

  Stream<List<Diagnose>> getAllDiagnose() => diagnoseRepo.snapshots().map((e) {
        return e.docs.map((e) => Diagnose.fromSnapshot(e)).toList();
      });
}
