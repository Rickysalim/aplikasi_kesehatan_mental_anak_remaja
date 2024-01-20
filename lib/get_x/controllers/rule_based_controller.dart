import 'package:aplikasi_kesehatan_mental_anak_remaja/get_x/repository/rule_based_repository_controller.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/models/rule_based_diagnose.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RuleBasedDiagnoseController extends GetxController {
  static RuleBasedDiagnoseController get instance => Get.find();

  final Rx<GlobalKey<FormState>> formKey =
      Rx<GlobalKey<FormState>>(GlobalKey<FormState>());

  Rx<TextEditingController> ruleBasedDetailController =
      Rx<TextEditingController>(TextEditingController());


  Rx<TextEditingController> maxController =
      Rx<TextEditingController>(TextEditingController());

  Rx<TextEditingController> minController =
      Rx<TextEditingController>(TextEditingController());

  Rx<TextEditingController> nameController =
      Rx<TextEditingController>(TextEditingController());

  RxMap<String, dynamic> ruleBasedRequest = RxMap({
    "rule_based_diagnose_id": "",
    "rule_based_diagnose_min_percent": 0.0,
    "rule_based_diagnose_max_percent": 0.0,
    "rule_based_diagnose_name": "",
  });

  void clearAllData() {
    nameController.value.text = "";
    minController.value.text = "";
    maxController.value.text = "";
    ruleBasedDetailController.value.text = "";
    setEdit.value = false;
    ruleBasedName.value = "";
  }

  void resetData() {
    formKey.value.currentState!.reset();
    clearAllData();
    update();
  }

  @override
  void onClose() {
    super.onClose();
    clearAllData();
  }

  RxBool setEdit = RxBool(false);

  RuleBaseDiagnoseRepositoryController ruleBaseDiagnoseRepositoryController =
      Get.put(RuleBaseDiagnoseRepositoryController());

  void setEditRuleBased(RuleBasedDiagnose rulebased) {
    setEdit.value = true;

    maxController.value.text = rulebased.ruleBasedDiagnoseMaxPercent.toString();
    minController.value.text = rulebased.ruleBasedDiagnoseMinPercent.toString();
    nameController.value.text = rulebased.ruleBasedDiagnoseName!;
    ruleBasedDetailController.value.text = rulebased.ruleBasedDiagnoseDetail!;
  
    ruleBasedRequest.value = {
      "rule_based_diagnose_id": rulebased.ruleBasedDiagnoseId,
      "rule_based_diagnose_min_percent":
          rulebased.ruleBasedDiagnoseMinPercent,
      "rule_based_diagnose_max_percent":
          rulebased.ruleBasedDiagnoseMaxPercent,
      "rule_based_diagnose_name": rulebased.ruleBasedDiagnoseName,
      "rule_based_diagnose_detail": rulebased.ruleBasedDiagnoseDetail
    };

    update();
  }

  Future<void> updateRuleBased() async {
    ruleBasedRequest["rule_based_diagnose_min_percent"] =
        minController.value.text;
    ruleBasedRequest["rule_based_diagnose_max_percent"] =
        maxController.value.text;
    ruleBasedRequest["rule_based_diagnose_name"] = nameController.value.text;
    ruleBasedRequest["rule_based_diagnose_detail"] = ruleBasedDetailController.value.text;

    await ruleBaseDiagnoseRepositoryController
        .updateRuleBased(ruleBasedRequest)
        .then((value) {
      setEdit.value = false;
      update();
    });
  }

  Future<void> deleteRuleBased(String id) async {
    await ruleBaseDiagnoseRepositoryController.deleteRuleBased(id);
  }

  Future<void> insertRuleBased() async {
    ruleBasedRequest.value = {
      "rule_based_diagnose_id": "",
      "rule_based_diagnose_min_percent": double.parse(minController.value.text),
      "rule_based_diagnose_max_percent": double.parse(maxController.value.text),
      "rule_based_diagnose_detail": ruleBasedDetailController.value.text,
      "rule_based_diagnose_name": nameController.value.text,
    };
    await ruleBaseDiagnoseRepositoryController
        .insertRuleBased(ruleBasedRequest);
  }

  RxString ruleBasedName = RxString("");


  void setSearch(String value) {
    ruleBasedName.value = value;
    update();
  }

  Stream<List<RuleBasedDiagnose>> searchRuleBased() =>
      ruleBaseDiagnoseRepositoryController.searchRuleBased(ruleBasedName.value);

  Stream<List<RuleBasedDiagnose>> getAllRuleBased() =>
      ruleBaseDiagnoseRepositoryController.getAllRuleBased();

  Stream<Map<String, dynamic>> getRuleBasedDiagnose() =>
      ruleBaseDiagnoseRepositoryController.getRuleBasedDiagnose();
}
