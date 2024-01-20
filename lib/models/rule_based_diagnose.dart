import 'package:cloud_firestore/cloud_firestore.dart';

class RuleBasedDiagnose {
  RuleBasedDiagnose(
      {this.ruleBasedDiagnoseId = "",
      this.ruleBasedDiagnoseMinPercent = 0.0,
      this.ruleBasedDiagnoseMaxPercent = 0.0,
      this.ruleBasedDiagnoseDetail = "",
      this.ruleBasedDiagnoseName = ""}) {}

  String? ruleBasedDiagnoseId;
  dynamic ruleBasedDiagnoseMinPercent;
  dynamic ruleBasedDiagnoseMaxPercent;
  String? ruleBasedDiagnoseName;
  String? ruleBasedDiagnoseDetail;

  factory RuleBasedDiagnose.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return RuleBasedDiagnose(
      ruleBasedDiagnoseId: document.id,
      ruleBasedDiagnoseMinPercent: data['rule_based_diagnose_min_percent'],
      ruleBasedDiagnoseMaxPercent: data['rule_based_diagnose_max_percent'],
      ruleBasedDiagnoseDetail: data["rule_based_diagnose_detail"],
      ruleBasedDiagnoseName: data['rule_based_diagnose_name'],
    );
  }

  factory RuleBasedDiagnose.fromQuerySnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();
    return RuleBasedDiagnose(
      ruleBasedDiagnoseId: snapshot.id,
      ruleBasedDiagnoseMinPercent: data['rule_based_diagnose_min_percent'],
      ruleBasedDiagnoseMaxPercent: data['rule_based_diagnose_max_percent'],
      ruleBasedDiagnoseDetail: data["rule_based_diagnose_detail"],
      ruleBasedDiagnoseName: data['rule_based_diagnose_name'],
    );
  }

  Map<String, dynamic> toMap() => {
      "rule_based_diagnose_id": ruleBasedDiagnoseId,
      "rule_based_diagnose_min_percent": ruleBasedDiagnoseMinPercent,
      "rule_based_diagnose_max_percent": ruleBasedDiagnoseMaxPercent,
      "rule_based_diagnose_detail": ruleBasedDiagnoseDetail,
      "rule_based_diagnose_name": ruleBasedDiagnoseName,
  };
}
