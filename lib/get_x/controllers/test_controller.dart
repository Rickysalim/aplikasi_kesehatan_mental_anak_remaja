import 'package:aplikasi_kesehatan_mental_anak_remaja/models/Test.dart';
import 'package:get/get.dart';

import '../repository/test_repository_controller.dart';

class TestController extends GetxController {
  static TestController get instance => Get.find();

  RxMap<String, dynamic> mapSelectedOptions = RxMap<String, dynamic>({});

  void setSelectionOptions(String question, String value) {
    mapSelectedOptions[question] = value;
    update();
  }

  void abortAllSelectionOptions() {
    mapSelectedOptions.clear();
  }

  final testRepositoryController = Get.put(TestRepositoryController());

  Stream<List<Test>> getAllTest() => testRepositoryController.getAllTest();
  
}
