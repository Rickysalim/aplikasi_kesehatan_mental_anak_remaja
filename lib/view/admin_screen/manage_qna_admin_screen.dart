import 'package:aplikasi_kesehatan_mental_anak_remaja/get_x/controllers/diagnose_controller.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/get_x/controllers/qa_controller.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/models/diagnose.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ManageQuestionAndAnswerAdminScreen extends StatelessWidget {
   ManageQuestionAndAnswerAdminScreen({super.key});

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
                  title: const Text('Question Answer'),
                  leading: Builder(builder: (BuildContext context) {
                    return IconButton(
                        onPressed: () {
                          controller.onClose();
                          Get.back();
                        },
                        icon: const Icon(Icons.arrow_back));
                  }),
                ),
                body: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: controller.formKey.value,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        TextFormField(
                          controller: controller.testTitleController.value,
                          decoration: const InputDecoration(
                            labelText: 'Symptom Code',
                            border: OutlineInputBorder(),
                          ),
                          // initialValue: controller.testQaData['test_title'].toString(),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter symptom code';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        Align(
                            alignment: Alignment.center,
                            child: ElevatedButton(
                                onPressed: () {
                                  controller.addTestQa();
                                },
                                child: const Text(
                                    'Add Question Answer For Certain Factor User'))),
                        controller.testQa.isNotEmpty
                            ? Expanded(
                                child: ListView.builder(
                                itemCount: controller.testQa.length,
                                itemBuilder: (context, index) {
                                  while (controller.formKeys.length <= index) {
                                    controller.formKeys
                                        .add(GlobalKey<FormState>());
                                  }
                                  while (controller.formSecondKeys.length <=
                                      index) {
                                    controller.formSecondKeys
                                        .add(GlobalKey<FormState>());
                                  }
                                  while (controller.formThirdKeys.length <=
                                      index) {
                                    controller.formThirdKeys
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
                                                padding:
                                                    const EdgeInsets.all(8),
                                                child: ElevatedButton(
                                                    child: const Text('Delete'),
                                                    onPressed: () {
                                                      controller
                                                          .removeTestQa(index);
                                                    })),
                                            Padding(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                child: Text(
                                                    'Question: ${controller.testQa[index]['question']}')),
                                            Form(
                                                key: controller
                                                    .formSecondKeys[index],
                                                child: Row(children: [
                                                  Expanded(
                                                      child: TextFormField(
                                                    decoration:
                                                        const InputDecoration(
                                                      labelText: 'Question',
                                                      border:
                                                          OutlineInputBorder(),
                                                    ),
                                                    validator: (value) {
                                                      final question =
                                                          controller
                                                                  .testQa[index]
                                                              ['question'];
                                                      if (question == null ||
                                                          question
                                                              .trim()
                                                              .isEmpty ||
                                                          question == "") {
                                                        if (value == null ||
                                                            value.isEmpty) {
                                                          return 'Please enter question';
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
                                                      child: const Text('Add'),
                                                      onPressed: () {
                                                        if (controller
                                                            .formSecondKeys[
                                                                index]
                                                            .currentState!
                                                            .validate()) {
                                                          controller
                                                              .onSubmitQuestion(
                                                                  index);
                                                          controller
                                                              .formSecondKeys[
                                                                  index]
                                                              .currentState!
                                                              .reset();
                                                        }
                                                      })
                                                ])),
                                            Padding(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                child: Text(
                                                    'CF expert: ${controller.testQa[index]['cf_expert']}')),
                                            Form(
                                                key: controller
                                                    .formThirdKeys[index],
                                                child: Row(children: [
                                                  Expanded(
                                                      child: TextFormField(
                                                    keyboardType:
                                                        TextInputType.number,
                                                    decoration:
                                                        const InputDecoration(
                                                      labelText:
                                                          'Certain Factor Expert Value',
                                                      border:
                                                          OutlineInputBorder(),
                                                    ),
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return 'Please enter certain factor expert value';
                                                      }
                                                      return null;
                                                    },
                                                    onChanged: (value) {
                                                      controller
                                                          .setExpertAnswer(
                                                              value);
                                                    },
                                                  )),
                                                  ElevatedButton(
                                                      child: const Text('Add'),
                                                      onPressed: () {
                                                        if (controller
                                                            .formThirdKeys[
                                                                index]
                                                            .currentState!
                                                            .validate()) {
                                                          controller
                                                              .onSubmitExpertValue(
                                                                  index);
                                                          controller
                                                              .formThirdKeys[
                                                                  index]
                                                              .currentState!
                                                              .reset();
                                                        }
                                                      })
                                                ])),
                                            const Padding(
                                                padding: EdgeInsets.all(8),
                                                child: Text('Answer:')),
                                            Row(children: [
                                              Expanded(
                                                  child: TextFormField(
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration:
                                                    const InputDecoration(
                                                  labelText: 'Key Answer',
                                                  border: OutlineInputBorder(),
                                                ),
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'Please enter key answer';
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
                                                decoration:
                                                    const InputDecoration(
                                                  labelText: 'Name Answer',
                                                  border: OutlineInputBorder(),
                                                ),
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'Please enter name answer';
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
                                                decoration:
                                                    const InputDecoration(
                                                  labelText:
                                                      'Certain Factor User Value',
                                                  border: OutlineInputBorder(),
                                                ),
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'Please enter some certain factor user value';
                                                  }
                                                  return null;
                                                },
                                                onChanged: (value) {
                                                  controller
                                                      .setValueAnswer(value);
                                                },
                                              )),
                                              ElevatedButton(
                                                  child: const Text('Add'),
                                                  onPressed: () {
                                                    if (controller
                                                        .formKeys[index]
                                                        .currentState!
                                                        .validate()) {
                                                      controller.onSubmitAnswer(
                                                          index);
                                                      controller.formKeys[index]
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
                                                      '$key: ${answer['name']} - :${answer['value']}',
                                                      style: const TextStyle(
                                                          fontSize: 20)),
                                                  ElevatedButton(
                                                      onPressed: () =>
                                                          controller
                                                              .deleteAnswer(
                                                                  index, key),
                                                      child:
                                                          const Text('Delete'))
                                                ]);
                                              }).toList(),
                                            )
                                          ]));
                                },
                              ))
                            : const Align(
                                alignment: Alignment.center,
                                child: Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Text('No Question Made Yet'))),
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
                                      if (controller.testQa.isEmpty) {
                                        Get.snackbar("Empty Field",
                                            "Please add atleast one Question And Answer");
                                      } else {
                                        await controller
                                            .insertQA()
                                            .then((value) {
                                          controller.resetData();
                                        });
                                      }
                                    }
                                  }
                                },
                                child: Text(controller.isEdit.value
                                    ? 'Update Certain Factor User'
                                    : 'Add Certain Factor User'),
                              ),
                              ElevatedButton(
                                onPressed: () => controller.resetData(),
                                child: const Text('Reset Data'),
                              )
                            ]),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            onChanged: (value) {
                              controller.setSearch(value);
                            },
                            decoration: const InputDecoration(
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
                                                  SizedBox(
                                                    width: 150,
                                                    child: Text(
                                                      diagnoses[index]
                                                          .testTitle
                                                          .toString(),
                                                      style: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  ElevatedButton(
                                                      child: const Text(
                                                          'Delete Qa'),
                                                      onPressed: () {
                                                        if (diagnoses[index]
                                                                    .testId !=
                                                                null ||
                                                            diagnoses[index]
                                                                    .testId !=
                                                                null) {
                                                          controller.deleteQA(
                                                              diagnoses[index]
                                                                  .testId
                                                                  .toString());
                                                        }
                                                      }),
                                                ])),
                                          ));
                                    },
                                  );
                                } else if (snapshot.hasError) {
                                  return const Center(
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
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else {
                                  return const Center(
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
