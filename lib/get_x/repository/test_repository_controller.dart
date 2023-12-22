import 'package:aplikasi_kesehatan_mental_anak_remaja/models/Test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class TestRepositoryController extends GetxController {
  static TestRepositoryController get instance => Get.find();

    final testRepo =
      FirebaseFirestore.instance.collection('Test');
    
     Stream<List<Test>> getAllTest() => testRepo 
      .snapshots()
      .map((e)  {
        return e.docs.map((e) => Test.fromSnapshot(e)).toList(); 
      });
 }