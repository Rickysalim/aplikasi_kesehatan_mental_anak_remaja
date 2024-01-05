import 'package:aplikasi_kesehatan_mental_anak_remaja/get_x/repository/rule_based_repository_controller.dart';
import 'package:get/get.dart';

class RuleBasedDiagnoseController extends GetxController {
  static RuleBasedDiagnoseController get instance => Get.find();
  RuleBaseDiagnoseRepositoryController ruleBaseDiagnoseRepositoryController = Get.put(RuleBaseDiagnoseRepositoryController());

  Stream<Map<String, dynamic>> getRuleBasedDiagnose() => ruleBaseDiagnoseRepositoryController.getRuleBasedDiagnose();
}
