import 'package:aplikasi_kesehatan_mental_anak_remaja/get_x/controllers/diagnose_history_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'package:get/get.dart';

import '../../models/DiagnoseHistory.dart';

class DiagnoseHistoryScreen extends StatelessWidget {
  static const String id = "diagnose_history_screen";

  final diagnoseHistoryController = Get.put(DiagnoseHistoryController());

  _ago(Timestamp t) {
    return timeago.format(t.toDate());
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(255, 253, 208, 1),
          title:
              Text('Diagnose History', style: TextStyle(color: Colors.black)),
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: StreamBuilder<List<DiagnoseHistory>>(
          
            stream: diagnoseHistoryController.getHistoryDiagnoseByUid(),
            initialData: [],
            builder: (context, snapshot) {
              List<DiagnoseHistory>? diagnose = snapshot.data!;
              if (snapshot.hasData && snapshot.data != null) {
                return Container(
                  decoration: BoxDecoration(
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
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.all(10),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(255, 220, 220, 1),
                              borderRadius: BorderRadius.circular(20.0)),
                          child: Column(
                            children: [
                              Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                      'Diagnose Date: ${_ago(diagnose[index].diagnose_history_date!)}',
                                      style: TextStyle(
                                          fontFamily: 'MochiyPopOne',
                                          fontSize: 5,
                                          color: Colors.black))),
                              Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                      'Received Symptoms: ${diagnose[index].diagnose_history_name!.toString()}',
                                      style: TextStyle(
                                          fontFamily: 'MochiyPopOne',
                                          fontSize: 5,
                                          color: Colors.black))),
                            ],
                          ));
                    },
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }
}
