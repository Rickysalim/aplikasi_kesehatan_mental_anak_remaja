import 'package:aplikasi_kesehatan_mental_anak_remaja/get_x/controllers/rule_based_controller.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/models/RuleBasedDiagnose.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RuleBasedDiagnoseAdminScreen extends StatelessWidget {
  RuleBasedDiagnoseController ruleBasedDiagnoseController =
      Get.put(RuleBasedDiagnoseController());

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
                    title: Text('Rule-Based Diagnose Admin'),
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
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Form(
                              key: controller.formKey.value,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  TextFormField(
                                    controller: controller.maxController.value,
                                    decoration: InputDecoration(
                                        labelText: 'Max Percent'),
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter some text';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: 20),
                                  TextFormField(
                                    controller: controller.minController.value,
                                    decoration: InputDecoration(
                                        labelText: 'Min Percent'),
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter some text';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: 20),
                                  TextFormField(
                                    controller: controller.nameController.value,
                                    decoration: InputDecoration(
                                        labelText: 'Diagnose Name'),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter some text';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: 20),
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
                                        ? 'Update'
                                        : 'Add'),
                                  ),
                                  ElevatedButton(
                                    onPressed: () => controller.resetData(),
                                    child: Text('Reset Data'),
                                  ),
                                ],
                              ),
                            ),
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
                              child: StreamBuilder<List<RuleBasedDiagnose>>(
                                stream: controller.searchRuleBased(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }

                                  if (snapshot.hasError) {
                                    return Center(
                                      child: Text('Error: ${snapshot.error}'),
                                    );
                                  }

                                  if (!snapshot.hasData ||
                                      snapshot.data!.isEmpty) {
                                    return Center(
                                      child: Text('No Video found.'),
                                    );
                                  }

                                  return GridView.builder(
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 8.0,
                                      mainAxisSpacing: 8.0,
                                    ),
                                    itemCount: snapshot.data!.length,
                                    itemBuilder: (context, index) {
                                      List<RuleBasedDiagnose>? rulebased =
                                          snapshot.data;
                                      return Padding(
                                        padding: EdgeInsets.all(10),
                                        child: GestureDetector(
                                          onLongPress: () => controller.deleteRuleBased(rulebased[index].rule_based_diagnose_id.toString()),
                                          onTap: () {
                                            print('tapped');
                                            controller.setEditRuleBased(
                                                rulebased[index]);
                                          },
                                          child: Container(
                                            width: 150,
                                            padding: EdgeInsets.all(5),
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
                                                        .rule_based_diagnose_name
                                                        .toString(),
                                                    style: TextStyle(
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
