import 'package:aplikasi_kesehatan_mental_anak_remaja/get_x/controllers/diagnose_controller.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/get_x/controllers/qa_controller.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/models/Diagnose.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuestionAnswerAdminScreen extends StatelessWidget {
  final qaController = QaController();

  final diagnoseController = DiagnoseController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QaController>(
        init: qaController,
        builder: (controller) {
          return WillPopScope(
              onWillPop: () async {
                controller.onClose();
                Get.back();
                return true;
              },
              child: Scaffold(
                appBar: AppBar(
                  title: Text('Question Answer'),
                  leading: Builder(builder: (BuildContext context) {
                    return IconButton(
                        onPressed: () {
                          controller.onClose();
                          Get.back();
                        },
                        icon: Icon(Icons.arrow_back));
                  }),
                ),
                body: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Form(
                    key: controller.formKey.value,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        TextFormField(
                          controller: controller.testTitleController.value,
                          decoration: InputDecoration(
                            labelText: 'Test Title',
                            border: OutlineInputBorder(),
                          ),
                          // initialValue: controller.testQaData['test_title'].toString(),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                            onPressed: () {
                              controller.addTestQa();
                            },
                            child: Text(controller.isEdit.value
                                ? 'Update QA'
                                : 'Add QA')),
                        controller.testQa.value.isNotEmpty
                            ? Expanded(
                                child: ListView.builder(
                                itemCount: controller.testQa.value.length,
                                itemBuilder: (context, index) {
                                  while (controller.formKeys.value.length <=
                                      index) {
                                    controller.formKeys.value
                                        .add(GlobalKey<FormState>());
                                  }
                                  while (
                                      controller.formSecondKeys.value.length <=
                                          index) {
                                    controller.formSecondKeys.value
                                        .add(GlobalKey<FormState>());
                                  }
                                  return Form(
                                      key: controller.formKeys[
                                          index], // Assign GlobalKey here
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                                padding: EdgeInsets.all(8),
                                                child: ElevatedButton(
                                                    child: Text('Delete'),
                                                    onPressed: () {
                                                      controller
                                                          .removeTestQa(index);
                                                    })),
                                            Padding(
                                                padding: EdgeInsets.all(8),
                                                child: Text(
                                                    'Question: ${controller.testQa.value[index]['question']}')),
                                            Form(
                                                key: controller
                                                    .formSecondKeys[index],
                                                child: Row(children: [
                                                  Expanded(
                                                      child: TextFormField(
                                                    decoration: InputDecoration(
                                                      labelText: 'Question',
                                                      border:
                                                          OutlineInputBorder(),
                                                    ),
                                                    validator: (value) {
                                                      final question =
                                                          controller.testQa
                                                                  .value[index]
                                                              ['question'];
                                                      if (question == null ||
                                                          question
                                                              .trim()
                                                              .isEmpty ||
                                                          question == "") {
                                                        if (value == null ||
                                                            value.isEmpty) {
                                                          return 'Please enter some value';
                                                        }
                                                        return null;
                                                      }
                                                      return null;
                                                    },
                                                    onChanged: (value) {
                                                      controller
                                                          .setQuestion(value);
                                                    },
                                                  )),
                                                  ElevatedButton(
                                                      child: Text('Add'),
                                                      onPressed: () {
                                                        if (controller
                                                            .formSecondKeys
                                                            .value[index]
                                                            .currentState!
                                                            .validate()) {
                                                          controller
                                                              .onSubmitQuestion(
                                                                  index);
                                                          controller
                                                              .formSecondKeys
                                                              .value[index]
                                                              .currentState!
                                                              .reset();
                                                        }
                                                      })
                                                ])),
                                            Padding(
                                                padding: EdgeInsets.all(8),
                                                child: Text('Answer:')),
                                            Row(children: [
                                              Expanded(
                                                  child: TextFormField(
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration: InputDecoration(
                                                  labelText: 'Key Answer',
                                                  border: OutlineInputBorder(),
                                                ),
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'Please enter some key';
                                                  }
                                                  return null;
                                                },
                                                onChanged: (value) {
                                                  controller
                                                      .setKeyAnswer(value);
                                                },
                                              )),
                                              Expanded(
                                                  child: TextFormField(
                                                decoration: InputDecoration(
                                                  labelText: 'Name Answer',
                                                  border: OutlineInputBorder(),
                                                ),
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'Please enter some name';
                                                  }
                                                  return null;
                                                },
                                                onChanged: (value) {
                                                  controller
                                                      .setNameAnswer(value);
                                                },
                                              )),
                                              Expanded(
                                                  child: TextFormField(
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration: InputDecoration(
                                                  labelText: 'Value Answer',
                                                  border: OutlineInputBorder(),
                                                ),
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'Please enter some value';
                                                  }
                                                  return null;
                                                },
                                                onChanged: (value) {
                                                  controller
                                                      .setValueAnswer(value);
                                                },
                                              )),
                                              ElevatedButton(
                                                  child: Text('Add'),
                                                  onPressed: () {
                                                    if (controller
                                                        .formKeys
                                                        .value[index]
                                                        .currentState!
                                                        .validate()) {
                                                      controller.onSubmitAnswer(
                                                          index);
                                                      controller
                                                          .formKeys
                                                          .value[index]
                                                          .currentState!
                                                          .reset();
                                                    }
                                                  }),
                                            ]),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: controller
                                                  .testQa[index]['answer']
                                                  .entries
                                                  .map<Widget>((entry) {
                                                String key = entry.key;
                                                Map<String, dynamic> answer =
                                                    entry.value;

                                                return Row(children: [
                                                  Text(
                                                      '$key: ${answer['name']} - ${answer['value']}',
                                                      style: TextStyle(
                                                          fontSize: 20)),
                                                  ElevatedButton(
                                                      onPressed: () =>
                                                          controller
                                                              .deleteAnswer(
                                                                  index, key),
                                                      child: Text('Delete'))
                                                ]) as Widget;
                                              }).toList(),
                                            )
                                          ]));
                                },
                              ))
                            : Align(
                                alignment: Alignment.center,
                                child: Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Text('No Question Made Yet'))),
                        SizedBox(height: 20),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                onPressed: () async {
                                  if (controller.formKey.value.currentState!
                                      .validate()) {
                                    if (controller.isEdit.value) {
                                      await controller.updateQa().then((value) {
                                        controller.resetData();
                                      });
                                    } else {
                                      await controller.insertQA().then((value) {
                                        controller.resetData();
                                      });
                                    }
                                  }
                                },
                                child: Text('Submit'),
                              ),
                              ElevatedButton(
                                onPressed: () => controller.resetData(),
                                child: Text('Reset Data'),
                              )
                            ]),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            onChanged: (value) {
                              controller.setSearch(value);
                            },
                            decoration: InputDecoration(
                              labelText: 'Search',
                              hintText: 'Enter search term',
                              prefixIcon: Icon(Icons.search),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Obx(() {
                            return StreamBuilder<List<Diagnose>>(
                              stream: controller.searchDiagnose(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  List<Diagnose>? diagnoses = snapshot.data!;
                                  return ListView.builder(
                                    itemCount: diagnoses.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                          onTap: () {
                                            controller.setEditDiagnose(
                                                diagnoses[index]);
                                          },
                                          child: Card(
                                            child: ListTile(
                                                title: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                  Text(
                                                    diagnoses[index]
                                                        .test_title
                                                        .toString(),
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontFamily:
                                                          'MochiyPopOne',
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  ElevatedButton(
                                                      child: Text('Delete Qa'),
                                                      onPressed: () {
                                                        if (diagnoses[index]
                                                                    .test_id !=
                                                                null ||
                                                            diagnoses[index]
                                                                    .test_id !=
                                                                null) {
                                                          controller.deleteQA(
                                                              diagnoses[index]
                                                                  .test_id
                                                                  .toString());
                                                        }
                                                      }),
                                                ])),
                                          ));
                                    },
                                  );
                                } else if (snapshot.hasError) {
                                  return Center(
                                    child: Text(
                                      'Error Occurred. Please Contact Our Support Team.',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'MochiyPopOne',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                      ),
                                    ),
                                  );
                                } else if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else {
                                  return Center(
                                    child: Text(
                                      'No Diagnose Data.',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'MochiyPopOne',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                      ),
                                    ),
                                  );
                                }
                              },
                            );
                          }),
                        )
                      ],
                    ),
                  ),
                ),
              ));
        });
  }
}
