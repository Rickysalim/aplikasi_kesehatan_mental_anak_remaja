import 'package:aplikasi_kesehatan_mental_anak_remaja/get_x/controllers/diagnose_controller.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/view/screens/landing_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DiagnoseResultScreen extends StatelessWidget {
  DiagnoseController diagnoseController = Get.put(DiagnoseController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              diagnoseController
                  .showWidgetResultTest(diagnoseController.resultTest.value),
              ElevatedButton(onPressed: () => Get.offAll(LandingScreen()), child: Text('Balik'))
            ])));
  }
}
