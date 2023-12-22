import 'dart:convert';

import 'package:aplikasi_kesehatan_mental_anak_remaja/get_x/controllers/diagnose_controller.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/models/Diagnose.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/view/screens/diagnose_result_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:get/get.dart';

class DiagnoseScreen extends StatelessWidget {
  static const String id = "diagnose_screen";

  DiagnoseController diagnoseController = Get.put(DiagnoseController());

  SwiperController swiperController = SwiperController();

  List<Widget> createWidgetList(
      DiagnoseController controller, List<dynamic> data) {
    return data.map((val) {
      final question = val['question'];

      final answerMap = val['answer'] as Map<String, dynamic>;

      List<Widget> radioListTiles = answerMap.entries.map((entry) {
        final answerValue = entry.value;
        return RadioListTile(
          title: Text(answerValue['name'].toString()),
          value: jsonEncode(answerValue),
          groupValue: controller.mapSelectedOptions[question],
          onChanged: (dynamic? value) {
            controller.setSelectionOptions(question, value);
          },
        );
      }).toList();

      return Column(children: [
        ListTile(title: Text(question.toString())),
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
                  body: StreamBuilder<List<Diagnose>>(
                      stream: diagnoseController.getAllDiagnose(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<Diagnose>? diagnose = snapshot.data!;
                          diagnose
                              .sort((a, b) => b.test_id!.compareTo(a.test_id!));

                          final questionsList = diagnose
                              .map((data) => (data.test_qa)
                                  .map(
                                      (qaItem) => qaItem['question'].toString())
                                  .toList())
                              .expand((questions) => questions)
                              .toList();

                          controller.setQuestions(questionsList);

                          return Container(
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.topRight,
                                      end: Alignment.bottomLeft,
                                      colors: [
                                    Color.fromRGBO(77, 67, 187, 1),
                                    Color.fromRGBO(255, 255, 255, 1),
                                  ])),
                              child: Swiper(
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
                                        child: ListTile(
                                            title: Text(diagnose[index]
                                                .test_title
                                                .toString())),
                                      ),
                                      ...createWidgetList(controller, testData),
                                      controller.showSubmitButton.value
                                          ? Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              ElevatedButton(
                                                  onPressed: () {
                                                    swiperController.previous();
                                                  },
                                                  child: Text('Prev')) ,
                                              ElevatedButton(
                                                  onPressed: () {
                                                    if (controller
                                                        .allOptionsSelected()) {
                                                      controller.showResultTest();
                                                      Get.to(DiagnoseResultScreen());
                                                    } else {
                                                      print('belum');
                                                    }
                                                  },
                                                  child: Text('Submit'))
                                            ])
                                          : Row(
                                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              index == 0 ? Text('') 
                                              : ElevatedButton(
                                                  onPressed: () {
                                                    swiperController.previous();
                                                  },
                                                  child: Text('Prev')),
                                              ElevatedButton(
                                                  onPressed: () {
                                                    swiperController.next();
                                                  },
                                                  child: Text('Next'))
                                            ])
                                    ]);
                                  },
                                  loop: false,
                                  itemCount: diagnose!.length,
                                  physics: NeverScrollableScrollPhysics(),
                                  pagination: null,
                                  control: null));
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text(snapshot.error.toString()),
                          );
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      })));
        });
  }
}
