import 'package:aplikasi_kesehatan_mental_anak_remaja/get_x/controllers/test_controller.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/models/Test.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TestScreen extends StatelessWidget {
  TestScreen(this.test);
  static const String id = "test_screen";

  Test? test;

  TestController testController = Get.put(TestController());

  List<Widget> createWidgetList(TestController controller) {
    return test!.test_qa.map((val) {
      final question = val['question'];
      final answerMap = val['answer'] as Map<String, dynamic>;

      List<Widget> radioListTiles = answerMap.entries.map((entry) {
        final answerValue = entry.value;
        return RadioListTile<String>(
          title: Text(answerValue['name'].toString()),
          value: answerValue.toString(),
          groupValue: controller.mapSelectedOptions[question],
          onChanged: (String? value) {
            controller.setSelectionOptions(question, value.toString());
          },
        );
      }).toList();

      return Column(children: [
        ListTile(title: Text(question.toString())),
        ...radioListTiles,
        Divider()
      ]);
    }).toList();
  }

  @override
  Widget build(Object context) {
    return GetBuilder<TestController>(
        init: testController,
        builder: (controller) {
          return WillPopScope(
            onWillPop: () async {
               controller.abortAllSelectionOptions();
               return true;
            },
            child:Scaffold(
              appBar: AppBar(
                title: Text(test!.test_name.toString()),
                centerTitle: true,
              ),
              body: test!.test_qa.isNotEmpty
                  ? ListView(

                    children: [
                      ...createWidgetList(controller),
                      Container(
                          padding: EdgeInsets.all(10),
                          child: ElevatedButton(
                              onPressed: () {}, child: Text('Submit')))
                    ])
                  : ListView(children: [
                      Text('Question Not Found', textAlign: TextAlign.center)
                    ])));
        });
  }
}
