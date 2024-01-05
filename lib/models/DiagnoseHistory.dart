import 'package:cloud_firestore/cloud_firestore.dart';

class DiagnoseHistory {
  DiagnoseHistory(
      {this.diagnose_history_date,
      this.diagnose_history_id = "",
      this.diagnose_history_name = "",
      this.user_id = ""}) {}

  Timestamp? diagnose_history_date = Timestamp.now();
  String? diagnose_history_id;
  String? diagnose_history_name;
  String? user_id;

  Map<String, dynamic> toMap() => {
        "diagnose_history_date": diagnose_history_date,
        "diagnose_history_id": diagnose_history_id,
        "diagnose_history_name": diagnose_history_name,
        "user_id": user_id
      };

  factory DiagnoseHistory.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return DiagnoseHistory(
        diagnose_history_date: data['diagnose_history_date'],
        diagnose_history_id: document.id,
        diagnose_history_name: data['diagnose_history_name'],
        user_id: data['user_id']);
  }
}
