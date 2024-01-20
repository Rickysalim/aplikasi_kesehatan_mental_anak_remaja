import 'package:aplikasi_kesehatan_mental_anak_remaja/get_x/controllers/diagnose_controller.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/get_x/controllers/diagnose_history_controller.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/get_x/controllers/rule_based_controller.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/get_x/guards/user_guards_controller.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/models/diagnose_history.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/view/user_screen/landing_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';

class DiagnoseResultScreen extends StatelessWidget {
  DiagnoseResultScreen({super.key});

  final ruleBasedDiagnoseController = Get.put(RuleBasedDiagnoseController());

  final diagnoseController = Get.put(DiagnoseController());

  final diagnoseHistoryController = Get.put(DiagnoseHistoryController());

  final userGuardsController = Get.put(UserGuardsController());

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
                      decoration: const BoxDecoration(
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
                                  return ListView(children: [
                                    Center(
                                        child: Text(
                                            "Result Mental Health Report: "
                                                .toString(),
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              fontFamily: 'MochiyPopOne',
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black,
                                            ))),
                                    Center(
                                        child: Text(
                                            "Your Level Of Depression: ${diagnoseController.resultTest.value.round()}%"
                                                .toString(),
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              fontFamily: 'MochiyPopOne',
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black,
                                            ))),
                                    const Divider(),
                                    Column(
                                        children: diagnoseController
                                            .mapSelectedOptions.entries
                                            .map((e) {
                                      var name = json
                                          .decode(e.value)["name"]
                                          .toString();
                                      return ListTile(
                                          title: Text(
                                              'Question: ${e.key.toString()}'),
                                          subtitle: Text('Answer: $name'));
                                    }).toList()),
                                    Center(
                                        child: Text(
                                            "Types of Symptoms: ${diagnose['rule_based_diagnose_name']}"
                                                .toString(),
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              fontFamily: 'MochiyPopOne',
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black,
                                            ))),
                                    const Divider(),
                                    Center(
                                        child: Text(
                                            "Detail Symptoms and recommendations"
                                                .toString(),
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              fontFamily: 'MochiyPopOne',
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black,
                                            ))),
                                    Center(
                                        child: Text(diagnose[
                                                'rule_based_diagnose_detail']
                                            .toString())),
                                    const Divider(),
                                    Center(
                                        child: ElevatedButton(
                                            onPressed: () async => await diagnoseHistoryController
                                                .insertToDiagnoseHistory(DiagnoseHistory(
                                                    diagnoseHistoryDate:
                                                        Timestamp.now(),
                                                    diagnoseHistoryRulebasedId:
                                                        diagnose[
                                                            'rule_based_diagnose_id'],
                                                    diagnoseHistoryLevelDepression: diagnoseController.resultTest.value.round(),
                                                    diagnoseHistoryUserAnswer:
                                                        diagnoseController
                                                            .mapSelectedOptions,
                                                    userId:
                                                        userGuardsController
                                                            .user
                                                            .currentUser!
                                                            .uid)),
                                            child: const Text('Save Diagnose', 
                                                          style: TextStyle(
                                                           fontFamily:
                                                                'MochiyPopOne',
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: Colors.black,
                                            ))))
                                  ]);
                                } else if (snapshot.hasError) {
                                  return Center(
                                    child: Text(
                                        'Error Occured Please Contact Our Support Team: ${snapshot.error.toString()}',
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontFamily: 'MochiyPopOne',
                                          fontSize: 32,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                        )),
                                  );
                                } else if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (snapshot.data == null) {
                                  return const Center(
                                      child: Text('No Diagnose Data',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: 'MochiyPopOne',
                                            fontSize: 32,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black,
                                          )));
                                } else {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              })))));
        });
  }
}
