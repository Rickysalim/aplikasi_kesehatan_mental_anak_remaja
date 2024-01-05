import 'package:aplikasi_kesehatan_mental_anak_remaja/get_x/controllers/diagnose_controller.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/models/RuleBasedDiagnose.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class RuleBaseDiagnoseRepositoryController extends GetxController {
  static RuleBaseDiagnoseRepositoryController get instance => Get.find();

  final ruleBasedDiagnoseRepo =
      FirebaseFirestore.instance.collection('RuleBasedDiagnose');
  final diagnoseController = Get.put(DiagnoseController());
  

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
