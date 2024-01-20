import 'dart:convert';
import 'package:aplikasi_kesehatan_mental_anak_remaja/get_x/controllers/diagnose_history_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DiagnoseHistoryScreen extends StatelessWidget {
  static const String id = "diagnose_history_screen";

  final diagnoseHistoryController = Get.put(DiagnoseHistoryController());

  DiagnoseHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(255, 253, 208, 1),
          title:
              const Text('Diagnose History', style: TextStyle(color: Colors.black)),
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: StreamBuilder<List<Map<String, dynamic>>>(
            stream: diagnoseHistoryController.getHistoryDiagnoseByUid(),
            initialData: const [],
            builder: (context, snapshot) {
              List<Map<String, dynamic>>? diagnose = snapshot.data!;
              if (snapshot.hasData && snapshot.data != null) {
                return Container(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                        Color.fromRGBO(255, 253, 208, 1),
                        Color.fromRGBO(255, 255, 255, 1),
                      ])),
                  child: ListView.builder(
                    itemCount: diagnose.length,
                    itemBuilder: (context, index) {
                      return Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.all(10),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: const Color.fromRGBO(255, 220, 220, 1),
                              borderRadius: BorderRadius.circular(20.0)),
                          child: Column(children: [
                            const Center(
                                child: Text(
                                    "Result Mental Health Report:",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'MochiyPopOne',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black,
                                    ))),
                            Center(
                                child: Text(
                                    "Your Level Of Depression: ${diagnose[index]["diagnose_history_level_depression"]}%"
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
                              children: diagnose[index]
                                      ["diagnose_history_user_answer"]
                                  .entries
                                  .map<Widget>((MapEntry<dynamic, dynamic> e) {
                                          var name = json
                                          .decode(e.value)["name"]
                                          .toString();
                                return ListTile(
                                  title: Text('Question: ${e.key.toString()}'),
                                  subtitle: Text('Answer: $name'),
                                );
                              }).toList(),
                            ),
                            Center(
                                child: Text(
                                    "Types of Symptoms: ${diagnose[index]['diagnose_history_name']}"
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
                                child: Text(diagnose[index]
                                        ['diagnose_history_detail']
                                    .toString()))
                          ]));
                    },
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }
}
