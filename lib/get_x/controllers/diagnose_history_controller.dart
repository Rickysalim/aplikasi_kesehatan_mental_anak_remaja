

import 'package:aplikasi_kesehatan_mental_anak_remaja/get_x/repository/diagnose_history_repository.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/models/DiagnoseHistory.dart';
import 'package:get/get.dart';

class DiagnoseHistoryController extends GetxController {
   static DiagnoseHistoryController get instance => Get.find();

   final diagnoseHistoryRepositoryController = Get.put(DiagnoseHistoryRepositoryController());
   
   Future<void> insertToDiagnoseHistory(DiagnoseHistory data) async {
     await diagnoseHistoryRepositoryController.insertToDiagnoseHistory(data);
   }

   Stream<List<DiagnoseHistory>> getHistoryDiagnoseByUid() => diagnoseHistoryRepositoryController.getHistoryDiagnoseByUid();
}