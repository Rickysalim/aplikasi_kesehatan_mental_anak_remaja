import 'dart:convert';

import 'package:aplikasi_kesehatan_mental_anak_remaja/get_x/controllers/diagnose_controller.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/models/Diagnose.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/view/user_screen/diagnose_result_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:get/get.dart';

class DiagnoseScreen extends StatelessWidget {
  static const String id = "diagnose_screen";

  final diagnoseController = Get.put(DiagnoseController());

  SwiperController swiperController = SwiperController();

  List<Widget> createWidgetList(
      DiagnoseController controller, List<dynamic>? data) {
    return data!.map((val) {
      final question = val['question'];

      final answerMap = val['answer'] as Map<String, dynamic>;

      List<Widget> radioListTiles = answerMap.entries.map((entry) {
        final answerValue = entry.value;
        return RadioListTile(
          title: Text(answerValue['name'].toString(),
              style: TextStyle(
                fontFamily: 'MochiyPopOne',
                fontSize: 10,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              )),
          value: jsonEncode(answerValue),
          groupValue: controller.mapSelectedOptions[question],
          onChanged: (dynamic? value) {
            controller.setSelectionOptions(question, value);
          },
        );
      }).toList();

      return Column(children: [
        ListTile(
            title: Text(question.toString(),
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: 'MochiyPopOne',
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ))),
        ...radioListTiles,
        controller.isRadioButtonNull(question),
        Divider()
      ]);
    }).toList();
  }

  Widget build(BuildContext context) {
    return GetBuilder<DiagnoseController>(
        init: diagnoseController,
        builder: (controller) {
          return WillPopScope(
              onWillPop: () async {
                controller.abortAllSelectionOptions();
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
                      child: 
                      StreamBuilder<List<Diagnose>>(
                          stream: controller.getAllDiagnose(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              List<Diagnose>? diagnose = snapshot.data!;

                              final questionsList = diagnose
                                  .map((data) => (data.test_qa)
                                      .map((qaItem) =>
                                          qaItem['question'].toString())
                                      .toList())
                                  .expand((questions) => questions)
                                  .toList();

                              controller.setQuestions(questionsList);

                              return Swiper(
                                  controller: swiperController,
                                  onIndexChanged: (int index) {
                                    if ((diagnose.length - 1) == index) {
                                      controller.setShowSubmitButton(true);
                                    } else {
                                      controller.setShowSubmitButton(false);
                                    }
                                  },
                                  itemBuilder: (context, index) {
                                    final testData = diagnose[index].test_qa
                                        as List<dynamic>;

                                    return ListView(children: [
                                      Container(
                                        alignment: Alignment.topCenter,
                                        padding: EdgeInsets.all(10),
                                        margin: EdgeInsets.all(8),
                                        child: ListTile(
                                            title: Text(
                                                diagnose[index]
                                                    .test_title
                                                    .toString(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily: 'MochiyPopOne',
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.black,
                                                ))),
                                      ),
                                      ...createWidgetList(controller, testData),
                                      controller.showSubmitButton.value
                                          ? Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                  ElevatedButton(
                                                      onPressed: () {
                                                        swiperController
                                                            .previous();
                                                      },
                                                      child: Text('Prev',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'MochiyPopOne',
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: Colors.black,
                                                          ))),
                                                  ElevatedButton(
                                                      onPressed: () {
                                                        if (controller
                                                            .allOptionsSelected()) {
                                                          controller
                                                              .showResultTest();
                                                          Get.offAll(
                                                              DiagnoseResultScreen());
                                                        } else {
                                                          Get.snackbar(
                                                              "Empty Field",
                                                              "Check Again Your Answer",
                                                              backgroundColor:
                                                                  Colors.red,
                                                              colorText:
                                                                  Colors.black);
                                                        }
                                                      },
                                                      child: Text('Submit',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'MochiyPopOne',
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: Colors.black,
                                                          )))
                                                ])
                                          : Row(
                                              mainAxisAlignment:
                                                  index == 0 ? MainAxisAlignment.center : MainAxisAlignment.spaceEvenly,
                                              children: [
                                                  index == 0
                                                      ? SizedBox.shrink()
                                                      : ElevatedButton(
                                                          onPressed: () {
                                                            swiperController
                                                                .previous();
                                                          },
                                                          child: Text('Prev',
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'MochiyPopOne',
                                                                fontSize: 10,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: Colors
                                                                    .black,
                                                              ))),
                                                  ElevatedButton(
                                                      onPressed: () {
                                                        swiperController.next();
                                                      },
                                                      child: Text('Next',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'MochiyPopOne',
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: Colors.black,
                                                          )))
                                                ])
                                    ]);
                                  },
                                  loop: false,
                                  itemCount: diagnose!.length,
                                  physics: NeverScrollableScrollPhysics(),
                                  pagination: null,
                                  control: null);
                            } else if (snapshot.hasError) {
                              return Center(
                                child: Text(
                                    'Error Occured Please Contact Out Support Team',
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
                          }))));
        });
  }
}
