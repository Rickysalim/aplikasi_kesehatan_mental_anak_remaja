import 'dart:convert';

import 'package:aplikasi_kesehatan_mental_anak_remaja/get_x/repository/diagnose_repository_controller.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/models/Diagnose.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DiagnoseController extends GetxController {
  static DiagnoseController get instance => Get.find();

  RxMap<String, dynamic> mapSelectedOptions = RxMap<String, dynamic>({});
  RxBool showSubmitButton = RxBool(false);
  RxList<String> questions = RxList<String>();
  RxDouble resultTest = RxDouble(0.0);

  void setShowSubmitButton(bool val) {
    showSubmitButton.value = val;
    update();
  }

  void setQuestions(List<String> questionList) {
    questions.addAll(questionList);
  }

  Widget isRadioButtonNull(String question) {
    if (mapSelectedOptions[question] == null) {
      return Align(
          alignment: Alignment.centerLeft,
          child: Padding(
              padding: EdgeInsets.all(10),
              child: Text('Tidak boleh kosong',
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Colors.red))));
    }
    return Text('');
  }

  bool allOptionsSelected() {
    for (String question in questions) {
      if (mapSelectedOptions[question] == null) {
        return false;
      }
    }
    return true;
  }

  void setSelectionOptions(String question, String value) {
    mapSelectedOptions[question] = value;
    update();
  }

  void abortAllSelectionOptions() {
    questions.clear();
    mapSelectedOptions.clear();
  }

  void showResultTest() {
    for(var entry in mapSelectedOptions.entries) {
       final data = jsonDecode(entry.value);
       resultTest.value += data['value'];
    }
    update();
  }

  Widget showWidgetResultTest(double value) {
     if(value >= 0.0 && value <= 30.0) {
       return Text('Aman');
     } else if (value >= 31.0 && value <= 60.0) {
       return Text('Baik');
     } else if (value >= 61.0 && value <= 100.0) {
       return Text('Stress');
     }
     return Text('Unknow');
  }

  final diagnoseRepositoryController = Get.put(DiagnoseRepositoryController());

  Stream<List<Diagnose>> getAllDiagnose() {
    return diagnoseRepositoryController.getAllDiagnose();
  }
}
