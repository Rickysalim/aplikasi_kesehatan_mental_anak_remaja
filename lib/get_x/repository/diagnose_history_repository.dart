import 'package:aplikasi_kesehatan_mental_anak_remaja/get_x/controllers/diagnose_controller.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/get_x/guards/user_guards_controller.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/get_x/repository/rule_based_repository_controller.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/models/diagnose_history.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/view/user_screen/landing_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class DiagnoseHistoryRepositoryController extends GetxController {
  static DiagnoseHistoryRepositoryController get instance => Get.find();

  final diagnoseRepo = FirebaseFirestore.instance.collection('DiagnoseHistory');
  final diagnoseRepoWithId =
      FirebaseFirestore.instance.collection('DiagnoseHistory').doc();
  final ruleBasedDiagnose = Get.put(RuleBaseDiagnoseRepositoryController());
  final diagnoseController = Get.put(DiagnoseController());
  final userGuardsController = Get.put(UserGuardsController());

  Future<void> insertToDiagnoseHistory(DiagnoseHistory data) async {
    data.diagnoseHistoryId = diagnoseRepoWithId.id;
    await diagnoseRepoWithId.set(data.toMap()).whenComplete(() {
      Get.snackbar("Completed", "Success Save Diagnose");
      diagnoseController.abortAllSelectionOptions();
      Get.offAll(LandingScreen());
    }).catchError((error, stackTrace) {
      Get.snackbar("Error", "Error Happen While Saving Data");
    });
  }

  Stream<List<Map<String, dynamic>>> getHistoryDiagnoseByUid() {
    final uId = userGuardsController.user.currentUser?.uid;

    return diagnoseRepo
    .where("user_id", isEqualTo: uId ?? "")
    .snapshots().asyncMap((event) async {
      List<Map<String, dynamic>> result = [];
      for(var e in event.docs) {
        Map<String, dynamic> mapToDiagnoseHistory = {
          "diagnose_history_date": e.data()["diagnose_history_date"],
          "diagnose_history_id": e.data()["diagnose_history_id"],
          "diagnose_history_user_answer": e.data()["diagnose_history_user_answer"],
          "diagnose_history_level_depression": e.data()["diagnose_history_level_depression"],
        };
        var snapshot = await ruleBasedDiagnose.ruleBasedDiagnoseRepo.where("rule_based_diagnose_id", isEqualTo: e.data()["diagnose_history_rulebased_id"]).get();

        for (var element in snapshot.docs) {
          mapToDiagnoseHistory["diagnose_history_name"] = element.data()["rule_based_diagnose_name"];
          mapToDiagnoseHistory["diagnose_history_detail"] = element.data()["rule_based_diagnose_detail"];
        }

        result.add(mapToDiagnoseHistory);
      }
      return result;
    });
  }
}