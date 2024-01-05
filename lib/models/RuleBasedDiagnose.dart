import 'package:cloud_firestore/cloud_firestore.dart';

class RuleBasedDiagnose {
  RuleBasedDiagnose(
      {this.rule_based_diagnose_id = "",
      this.rule_based_diagnose_min_percent = 0.0,
      this.rule_based_diagnose_max_percent = 0.0,
      this.rule_based_diagnose_name = ""}) {}

  String? rule_based_diagnose_id;
  dynamic rule_based_diagnose_min_percent;
  dynamic rule_based_diagnose_max_percent;
  String? rule_based_diagnose_name;

  factory RuleBasedDiagnose.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return RuleBasedDiagnose(
      rule_based_diagnose_id: document.id,
      rule_based_diagnose_min_percent: data['rule_based_diagnose_min_percent'],
      rule_based_diagnose_max_percent: data['rule_based_diagnose_max_percent'],
      rule_based_diagnose_name: data['rule_based_diagnose_name'],
    );
  }

  factory RuleBasedDiagnose.fromQuerySnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();

    return RuleBasedDiagnose(
      rule_based_diagnose_id: snapshot.id,
      rule_based_diagnose_min_percent: data['rule_based_diagnose_min_percent'],
      rule_based_diagnose_max_percent: data['rule_based_diagnose_max_percent'],
      rule_based_diagnose_name: data['rule_based_diagnose_name'],
    );
  }

  Map<String, dynamic> toMap() => {
      "rule_based_diagnose_id": rule_based_diagnose_id,
      "rule_based_diagnose_min_percent": rule_based_diagnose_min_percent,
      "rule_based_diagnose_max_percent": rule_based_diagnose_max_percent,
      "rule_based_diagnose_name": rule_based_diagnose_name,
  };
}
