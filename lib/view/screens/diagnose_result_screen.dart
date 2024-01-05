import 'package:aplikasi_kesehatan_mental_anak_remaja/get_x/controllers/diagnose_controller.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/get_x/controllers/diagnose_history_controller.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/get_x/controllers/rule_based_controller.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/get_x/guards/user_guards_controller.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/models/DiagnoseHistory.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/view/screens/landing_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DiagnoseResultScreen extends StatelessWidget {
  RuleBasedDiagnoseController ruleBasedDiagnoseController =
      Get.put(RuleBasedDiagnoseController());
  DiagnoseController diagnoseController = Get.put(DiagnoseController());
  DiagnoseHistoryController diagnoseHistoryController =
      Get.put(DiagnoseHistoryController());
  UserGuardsController userGuardsController = Get.put(UserGuardsController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RuleBasedDiagnoseController>(
        init: ruleBasedDiagnoseController,
        builder: (controller) {
          return WillPopScope(
              onWillPop: () async {
                Get.to(LandingScreen());
                diagnoseController.abortAllSelectionOptions();
                return true;
              },
              child: Scaffold(
                  body: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                            Color.fromRGBO(255, 253, 208, 1),
                            Color.fromRGBO(255, 255, 255, 1),
                          ])),
                      child: Align(
                          alignment: Alignment.center,
                          child: StreamBuilder(
                              stream: controller.getRuleBasedDiagnose(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData && snapshot.data != null) {
                                  final diagnose = snapshot.data!;
                                  return Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Center(
                                            child: Text(
                                                "Your Level Of Depression: ${diagnoseController.resultTest.value.round()}%"
                                                    .toString(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily: 'MochiyPopOne',
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.black,
                                                ))),
                                        Center(
                                            child: Text(
                                                "Types of Symptoms: ${diagnose['rule_based_diagnose_name']}"
                                                    .toString(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily: 'MochiyPopOne',
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.black,
                                                ))),
                                        Center(
                                            child: ElevatedButton(
                                                onPressed: () async => await diagnoseHistoryController
                                                    .insertToDiagnoseHistory(DiagnoseHistory(
                                                        diagnose_history_date:
                                                            Timestamp.now(),
                                                        diagnose_history_name: diagnose[
                                                            'rule_based_diagnose_name'],
                                                        user_id:
                                                            userGuardsController
                                                                .user
                                                                .currentUser!
                                                                .uid)),
                                                child: Text('SIMPAN HASIL')))
                                      ]);
                                } else if (snapshot.hasError) {
                                  print(snapshot.error);
                                  return Center(
                                    child: Text(
                                        'Error Occured Please Contact Our Support Team: ${snapshot.error.toString()}',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: 'MochiyPopOne',
                                          fontSize: 32,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                        )),
                                  );
                                } else if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (snapshot.data == null) {
                                  return Center(
                                      child: Text('No Diagnose Data',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: 'MochiyPopOne',
                                            fontSize: 32,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black,
                                          )));
                                } else {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              })))));
        });
  }
}
