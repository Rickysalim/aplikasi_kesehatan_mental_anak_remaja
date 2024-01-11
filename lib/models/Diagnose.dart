import 'package:cloud_firestore/cloud_firestore.dart';

class Diagnose {
  Diagnose({
    this.test_id = "",
    this.test_cover_url = "",
    this.test_title = "",
    required this.test_qa,
  }) {}

  String? test_id;
  String? test_title;
  String? test_cover_url;
  List<dynamic> test_qa = [];

  Map<String,dynamic> toMap() => {
    "test_id": test_id,
    "test_title": test_title,
    "test_cover_url": test_cover_url,
    "test_qa": test_qa
  };

  factory Diagnose.fromMap(Map<String, dynamic> data) {
    return Diagnose(
        test_id: "",
        test_title: data["test_title"],
        test_cover_url: "",
        test_qa: data["test_qa"]);
  }

  factory Diagnose.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return Diagnose(
      test_id: document.id,
      test_title: data['test_title'],
      test_cover_url: data['test_cover_url'],
      test_qa: data['test_qa'],
    );
  }
}
