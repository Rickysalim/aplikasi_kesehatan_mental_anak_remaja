import 'package:cloud_firestore/cloud_firestore.dart';

class Diagnose {
  Diagnose({
    this.testId = "",
    this.testTitle = "",
    required this.testQa,
  });

  final String? testId;
  final String? testTitle;
  List<dynamic> testQa = [];
  
  factory Diagnose.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return Diagnose(
      testId: document.id,
      testTitle: data['test_title'],
      testQa: data['test_qa'],
    );
  }
}
