import 'package:aplikasi_kesehatan_mental_anak_remaja/get_x/controllers/diagnose_controller.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/models/RuleBasedDiagnose.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RuleBaseDiagnoseRepositoryController extends GetxController {
  static RuleBaseDiagnoseRepositoryController get instance => Get.find();

  final ruleBasedDiagnoseRepo =
      FirebaseFirestore.instance.collection('RuleBasedDiagnose');
  final diagnoseController = Get.put(DiagnoseController());

    final ruleBasedDiagnoseRepoWithId =
      FirebaseFirestore.instance.collection('RuleBasedDiagnose').doc();
  
  Stream<List<RuleBasedDiagnose>> searchRuleBased(String ruleBasedName) {
  if (ruleBasedName.isEmpty) {
    return ruleBasedDiagnoseRepo
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => RuleBasedDiagnose.fromSnapshot(doc)).toList());
  } else {
    return ruleBasedDiagnoseRepo
        .snapshots()
        .map((snapshot) => snapshot.docs
            .where((doc) {
              String sqlLikePattern = ".*${RegExp.escape(ruleBasedName)}.*";
              RegExp pattern = RegExp(sqlLikePattern, caseSensitive: false);
              return pattern.hasMatch(doc["rule_based_diagnose_name"]);
            })
            .map((doc) => RuleBasedDiagnose.fromSnapshot(doc))
            .toList());
  }
}

  Future<void> deleteRuleBased(String id) async {
    await ruleBasedDiagnoseRepo.doc(id).delete().whenComplete(() {
        Get.snackbar("Berhasil", "Berhasil Menghapus Data Rule Based",
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.green,
            colorText: Colors.black);
    }).catchError((e) {
        Get.snackbar("Berhasil", "Terjadi kesalahan saat menghapus data",
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.black);
    });
  }

  Future<void> updateRuleBased(Map<String, dynamic> data) async {
    await ruleBasedDiagnoseRepo.doc(data["rule_based_diagnose_id"]).update(data).whenComplete(() {
        Get.snackbar("Berhasil", "Berhasil Memperbaharui Data Rule Based",
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.green,
            colorText: Colors.black);
    }).catchError((e) {
        Get.snackbar("Berhasil", "Terjadi kesalahan saat memperbaharui data",
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.black);
    });
  }

  Future<void> insertRuleBased(Map<String, dynamic> data) async {
    data['rule_based_diagnose_id'] = ruleBasedDiagnoseRepoWithId.id;

    await ruleBasedDiagnoseRepoWithId.set(data).whenComplete(() {
        Get.snackbar("Berhasil", "Berhasil Menambah Data Rule Based",
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.green,
            colorText: Colors.black);
    }).catchError((e) {
        Get.snackbar("Berhasil", "Terjadi kesalahan saat menambah data",
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.black);
    });
  }

  Stream<List<RuleBasedDiagnose>> getAllRuleBased() => ruleBasedDiagnoseRepo
      .snapshots()
      .map((e) => e.docs.map((e) => RuleBasedDiagnose.fromSnapshot(e)).toList());

  Stream<Map<String, dynamic>> getRuleBasedDiagnose() {
    return ruleBasedDiagnoseRepo.snapshots().map((event) {
      return event.docs.fold<Map<String, dynamic>>({},
          (Map<String, dynamic> filteredData, doc) {
        if (diagnoseController.resultTest.value >=
                doc['rule_based_diagnose_min_percent'] &&
            diagnoseController.resultTest.value <=
                doc['rule_based_diagnose_max_percent']) {
          RuleBasedDiagnose diagnose = RuleBasedDiagnose.fromQuerySnapshot(doc);
          filteredData.addAll(diagnose.toMap());
        }
        return filteredData;
      });
    });
  }
}
