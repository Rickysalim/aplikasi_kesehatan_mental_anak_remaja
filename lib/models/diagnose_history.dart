import 'package:cloud_firestore/cloud_firestore.dart';

class DiagnoseHistory {
  DiagnoseHistory(
      {this.diagnoseHistoryDate,
      this.diagnoseHistoryId = "",
      this.diagnoseHistoryUserAnswer,
      this.diagnoseHistoryRulebasedId = "",
      this.diagnoseHistoryLevelDepression,
      this.userId = ""});

  Timestamp? diagnoseHistoryDate = Timestamp.now();
  Map<String, dynamic>? diagnoseHistoryUserAnswer = {};
  dynamic diagnoseHistoryLevelDepression;
  String? diagnoseHistoryRulebasedId;
  String? diagnoseHistoryId;
  String? userId;

  Map<String, dynamic> toMap() => {
    "diagnose_history_date": diagnoseHistoryDate,
    "diagnose_history_id": diagnoseHistoryId,
    "diagnose_history_rulebased_id": diagnoseHistoryRulebasedId,
    "diagnose_history_level_depression": diagnoseHistoryLevelDepression,
    "diagnose_history_user_answer": diagnoseHistoryUserAnswer,
    "user_id": userId
  };

  factory DiagnoseHistory.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return DiagnoseHistory(
        diagnoseHistoryId: document.id,
        diagnoseHistoryDate: data['diagnose_history_date'],
        diagnoseHistoryRulebasedId: data['diagnose_history_rulebased_id'],
        diagnoseHistoryLevelDepression: data["diagnose_history_level_depression"],
        diagnoseHistoryUserAnswer: data['diagnose_history_user_answer'],
        userId: data['user_id']);
  }
}
