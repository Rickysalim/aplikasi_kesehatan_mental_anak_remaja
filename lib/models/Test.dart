
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';



class Test {
   Test({
    this.test_id = "",
    this.test_cover_url = "",
    this.test_name = "",
    required this.test_qa,
  }) {}

  String? test_id;
  String? test_name;
  String? test_cover_url;
  List<dynamic> test_qa = [];


  factory Test.fromSnapshot(DocumentSnapshot<Map<String,dynamic>>  document) {
    final data = document.data()!;
    return Test(
      test_id: document.id,
      test_name: data['test_name'],
      test_cover_url: data['test_cover_url'],
      test_qa: data['test_qa'],
    );
  }
}