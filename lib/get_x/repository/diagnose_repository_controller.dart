import 'package:aplikasi_kesehatan_mental_anak_remaja/models/Diagnose.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DiagnoseRepositoryController extends GetxController {
  static DiagnoseRepositoryController get instance => Get.find();

  final diagnoseRepo = FirebaseFirestore.instance.collection('Diagnose');

  final diagnopeRepoWithId = FirebaseFirestore.instance.collection('Diagnose').doc();
  
  Stream<List<Diagnose>> searchDiagnose(String testTitle) {
  if (testTitle.isEmpty) {
    return diagnoseRepo
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => Diagnose.fromSnapshot(doc)).toList());
  } else {
    return diagnoseRepo
        .snapshots()
        .map((snapshot) => snapshot.docs
            .where((doc) {
              String sqlLikePattern = ".*${RegExp.escape(testTitle)}.*";
              RegExp pattern = RegExp(sqlLikePattern, caseSensitive: false);
              return pattern.hasMatch(doc["test_title"]);
            })
            .map((doc) => Diagnose.fromSnapshot(doc))
            .toList());
  }
}


  Future<void> deleteQA(String doc) async {
    await diagnoseRepo.doc(doc).delete().whenComplete(() {
      Get.snackbar("Berhasil", "Berhasil Menghapus Data Diagnosa",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.black);
    }).catchError((error, stackTrace) {
      Get.snackbar("Kesalahan", "Terjadi Kesalahan saat Menghapus Data",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    });;
  }

  Future<void> updateQA(Map<String,dynamic> data) async {
    await diagnoseRepo.doc(data['test_id']).update(data).whenComplete(() {
      Get.snackbar("Berhasil", "Berhasil Memperbaharui Data Diagnosa",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.black);
    }).catchError((error, stackTrace) {
      Get.snackbar("Kesalahan", "Terjadi Kesalahan saat Meperbaharui data",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    });
  }

  Future<void> insertQA(Map<String,dynamic> data) async {
    data["test_id"] = diagnopeRepoWithId.id;
    await diagnopeRepoWithId.set(data).whenComplete(() {
      Get.snackbar("Berhasil", "Berhasil Menyimpan Data Diagnosa",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.black);
    }).catchError((error, stackTrace) {
      Get.snackbar("Kesalahan", "Terjadi Kesalahan saat menyimpan data",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    });
  }

  Stream<List<Diagnose>> getAllDiagnose() => diagnoseRepo.snapshots().map((e) {
        return e.docs.map((e) => Diagnose.fromSnapshot(e)).toList();
      });
      
}
