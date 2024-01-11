import 'dart:ffi';

import 'package:aplikasi_kesehatan_mental_anak_remaja/models/Diagnose.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../repository/diagnose_repository_controller.dart';

class QaController extends GetxController {
  static QaController get instance => Get.find();

  final Rx<GlobalKey<FormState>> formKey =
      Rx<GlobalKey<FormState>>(GlobalKey<FormState>());

  final RxList<GlobalKey<FormState>> formKeys =
      RxList<GlobalKey<FormState>>([]);

  final RxList<GlobalKey<FormState>> formSecondKeys =
      RxList<GlobalKey<FormState>>([]);

  final Rx<TextEditingController> testTitleController =
      Rx<TextEditingController>(TextEditingController());

  final RxString testCoverUrl = RxString("");
  final RxList<dynamic> testQa = RxList<dynamic>([]);

  final RxString question = RxString("");
  final RxString keyAnswer = RxString("");
  final RxString nameAnswer = RxString("");
  final RxString valueAnswer = RxString("");

  final RxBool isEdit = RxBool(false);

  final RxMap<String, dynamic> testQaData = RxMap<String, dynamic>({
    "test_id": "",
    "test_cover_url": "",
    "test_title": "",
    "test_qa": [],
  });

  void addTestQa() {
    testQa.add({"answer": {}, "question": ""});
    update();
  }

  void removeTestQa(int index) {
    testQa.removeAt(index);
    update();
  }

  void setQuestion(String value) {
    question.value = value;
    update();
  }

  void setKeyAnswer(String value) {
    keyAnswer.value = value;
    update();
  }

  void setNameAnswer(String value) {
    nameAnswer.value = value;
    update();
  }

  void setValueAnswer(String value) {
    valueAnswer.value = value;
    update();
  }

  void deleteAnswer(int index, String key) {
    if (testQa.length > index) {
      testQa[index]['answer'].remove(key);
      update();
    }
  }

  void onSubmitQuestion(int index) {
    testQa[index]['question'] = question.value;
    update();
  }

  void resetData(){
    formKey.value.currentState!.reset();
    clearAllData();
    update();
  }

  void clearAllData() {
    testCoverUrl.value = "";
    testQa.value = [];
    testQaData.value = {
      "test_id": "",
      "test_cover_url": "",
      "test_title": "",
      "test_qa": null,
    };
    question.value = "";
    keyAnswer.value = "";
    nameAnswer.value = "";
    valueAnswer.value = "";
    testTitleController.value.text = "";
    isEdit.value = false;
    testTitle.value = "";
    formKeys.value = [];
    formSecondKeys.value = [];

  }

  @override
  void onClose() {
    super.onClose();
    clearAllData();
  }

  void onSubmitAnswer(int index) {
    testQa[index]['answer'][keyAnswer.value] = {
      "name": nameAnswer.value,
      "value": valueAnswer.value.runtimeType == "String"
          ? double.parse(valueAnswer.value)
          : 0.0
    };
    update();
  }

  void setEditDiagnose(Diagnose data) {
    isEdit.value = true;
    testQa.value = data.test_qa;
    testTitleController.value.text = data.test_title!;
    testQaData.value = {
      "test_id": data.test_id,
      "test_cover_url": data.test_cover_url,
      "test_title": data.test_title!,
      "test_qa": testQa.value,
    };

    update();
  }

  final diagnoseRepositoryController = Get.put(DiagnoseRepositoryController());

  RxString testTitle = RxString("");

  void setSearch(String value) {
    testTitle.value = value;
    update();
  }

  Stream<List<Diagnose>> searchDiagnose() =>
      diagnoseRepositoryController.searchDiagnose(testTitle.value);

  Future<void> updateQa() async {
    testQaData["test_cover_url"] = testCoverUrl.value;
    testQaData["test_title"] = testTitleController.value.text;
    testQaData["test_qa"] = testQa.value;
    await diagnoseRepositoryController.updateQA(testQaData).then((value) {
      isEdit.value = false;
      update();
    });
  }

  Future<void> insertQA() async {
    testQaData.value = {
      "test_id": "",
      "test_cover_url": testCoverUrl.value,
      "test_title": testTitleController.value.text,
      "test_qa": testQa,
    };
    await diagnoseRepositoryController.insertQA(testQaData);
  }

  Future<void> deleteQA(String doc) async {
    await diagnoseRepositoryController.deleteQA(doc);
  }
}
