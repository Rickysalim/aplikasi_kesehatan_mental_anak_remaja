import 'package:aplikasi_kesehatan_mental_anak_remaja/get_x/controllers/rule_based_controller.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/models/rule_based_diagnose.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ManageRuleBasedDiagnoseAdminScreen extends StatelessWidget {
  ManageRuleBasedDiagnoseAdminScreen({super.key});

  final ruleBasedDiagnoseController = Get.put(RuleBasedDiagnoseController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RuleBasedDiagnoseController>(
        init: ruleBasedDiagnoseController,
        builder: (controller) {
          return WillPopScope(
              onWillPop: () async {
                controller.onClose();
                return true;
              },
              child: Scaffold(
                  appBar: AppBar(
                    title: const Text('Rule-Based Diagnose Admin'),
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
                      padding: const EdgeInsets.all(20.0),
                      child: Column(children: [
                        Expanded(
                            child: ListView(children: <Widget>[
                          Form(
                            key: controller.formKey.value,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter rule based detail';
                                    }
                                    return null;
                                  },
                                  controller: controller
                                      .ruleBasedDetailController.value,
                                  decoration: const InputDecoration(
                                      labelText: 'Rule Based Detail'),
                                  maxLines: 10,
                                ),
                                TextFormField(
                                  controller: controller.maxController.value,
                                  decoration: const InputDecoration(
                                      labelText: 'Max Percent'),
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter max percent';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 20),
                                TextFormField(
                                  controller: controller.minController.value,
                                  decoration: const InputDecoration(
                                      labelText: 'Min Percent'),
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter min percent';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 20),
                                TextFormField(
                                  controller: controller.nameController.value,
                                  decoration: const InputDecoration(
                                      labelText: 'Diagnose Name'),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 20),
                                ElevatedButton(
                                  onPressed: () async {
                                    if (controller.formKey.value.currentState!
                                        .validate()) {
                                      if (controller.setEdit.value) {
                                        await controller
                                            .updateRuleBased()
                                            .then((value) {
                                          controller.resetData();
                                        });
                                      } else {
                                        await controller
                                            .insertRuleBased()
                                            .then((value) {
                                          controller.resetData();
                                        });
                                      }
                                    }
                                  },
                                  child: Text(controller.setEdit.value
                                      ? 'Update Rule Based'
                                      : 'Add Rule Based'),
                                ),
                                ElevatedButton(
                                  onPressed: () => controller.resetData(),
                                  child: const Text('Reset Data'),
                                ),
                              ],
                            ),
                          ),
                        ])),
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
                          child: StreamBuilder<List<RuleBasedDiagnose>>(
                            stream: controller.searchRuleBased(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }

                              if (snapshot.hasError) {
                                return Center(
                                  child: Text('Error: ${snapshot.error}'),
                                );
                              }

                              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                                return const Center(
                                  child: Text('No Rule Based found.'),
                                );
                              }

                              return GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 8.0,
                                  mainAxisSpacing: 8.0,
                                ),
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  List<RuleBasedDiagnose>? rulebased =
                                      snapshot.data;
                                  return Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: GestureDetector(
                                      onLongPress: () => controller
                                          .deleteRuleBased(rulebased[index]
                                              .ruleBasedDiagnoseId
                                              .toString()),
                                      onTap: () {
                                        controller
                                            .setEditRuleBased(rulebased[index]);
                                      },
                                      child: Container(
                                        width: 150,
                                        padding: const EdgeInsets.all(5),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: 150,
                                              child: Text(
                                                rulebased![index]
                                                    .ruleBasedDiagnoseName
                                                    .toString(),
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ]))));
        });
  }
}
