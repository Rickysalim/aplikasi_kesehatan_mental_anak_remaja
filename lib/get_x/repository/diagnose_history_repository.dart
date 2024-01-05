import 'package:aplikasi_kesehatan_mental_anak_remaja/get_x/controllers/diagnose_controller.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/get_x/guards/user_guards_controller.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/get_x/repository/rule_based_repository_controller.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/models/DiagnoseHistory.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/view/screens/landing_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DiagnoseHistoryRepositoryController extends GetxController {
  static DiagnoseHistoryRepositoryController get instance => Get.find();

  final diagnoseRepo = FirebaseFirestore.instance.collection('History');
  final diagnoseRepoWithId =
      FirebaseFirestore.instance.collection('History').doc();
  final ruleBasedDiagnose = Get.put(RuleBaseDiagnoseRepositoryController());
  final diagnoseController = Get.put(DiagnoseController());
  final userGuardsController = Get.put(UserGuardsController());

  Future<void> insertToDiagnoseHistory(DiagnoseHistory data) async {
    data.diagnose_history_id = diagnoseRepoWithId.id;
    await diagnoseRepoWithId.set(data.toMap()).whenComplete(() {
      Get.snackbar("Berhasil", "Berhasil Menyimpan Rekam Diagnosa",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.black);
      diagnoseController.abortAllSelectionOptions();
      Get.offAll(LandingScreen());
    }).catchError((error, stackTrace) {
      Get.snackbar("Kesalahan", "Terjadi Kesalahan saat menyimpan data",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    });
  }

  Stream<List<DiagnoseHistory>> getHistoryDiagnoseByUid() {
    final uId = userGuardsController.user.currentUser?.uid;

    return diagnoseRepo.where("user_id", isEqualTo: uId ?? "").snapshots().map(
        (event) =>
            event.docs.map((e) => DiagnoseHistory.fromSnapshot(e)).toList());
  }
}

        // var mappingRuleBased = {};
        // if (e.data().isNotEmpty) {
        //   final ruleBasedId = e.data()["rule_based_id"]
        //   final diagnoseDate = e.data()["diagnose_history_date"];
        // ruleBasedDiagnose.ruleBasedDiagnoseRepo
        //     .where("rule_based_diagnose_id", isEqualTo: ruleBasedId)
        //     .snapshots()
        //     .map((event) => {
        //           event.docs.map((e) {
        //             mappingRuleBased.assign(
        //                 "rule_based_name", e['rule_based_diagnose_name']);
        //           })
        //         });
        //   mappingRuleBased.assign("diagnose_history_date", diagnoseDate);
        // } else {
        //   mappingRuleBased.addAll({"rule_based_name":"Unknown", "diagnose_history_date":"Unknown Date"});
        // }
        // mappingRuleBased.assign("diagnose_history_date",  e.data()["diagnose_history_date"]);
        // return mappingRuleBased;