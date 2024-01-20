import 'dart:convert';
import 'package:aplikasi_kesehatan_mental_anak_remaja/models/diagnose.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class DiagnoseRepositoryController extends GetxController {
  static DiagnoseRepositoryController get instance => Get.find();

  final diagnoseRepo = FirebaseFirestore.instance.collection('Diagnose');

  Future<double> getInitialCFExpert() async {
    double cfTotal = 0.0;

    await diagnoseRepo.snapshots().first.then((QuerySnapshot event) async {
      if (event.docs.isNotEmpty) {
        QueryDocumentSnapshot firstDocument = event.docs.first;
        cfTotal = firstDocument.get('test_qa')[0]?["cf_expert"] ?? 0.0;
      }
    });

    return cfTotal;
  }

  double combineCF(double currentCF, double nextCF) {
    return currentCF + nextCF * (1 - currentCF);
  }

  Future<double> calculateDiagnose(Map<String, dynamic> data) async {
    List<double> cfExpert = [];
    List<double> cfUser = [];
    List<double> cfCombination = [];

    // double cfTotal = 0.0;

    var snapshot = await diagnoseRepo.snapshots().first;
    for (var expertDiagnoseData in snapshot.docs) {
      cfExpert
          .add(expertDiagnoseData.data()["test_qa"][0]["cf_expert"].toDouble());
    }

    for (var diagnoseData in data.values) {
      cfUser.add(jsonDecode(diagnoseData)["value"].toDouble());
    }

    for (int index = 0; index < cfExpert.length; index++) {
      cfCombination.add(cfExpert[index] * cfUser[index]);
    }

    double cfTotal = await getInitialCFExpert() *
            jsonDecode(data.entries.first.value)["value"].toDouble() +
        (cfCombination[1] *
            (1 -
                (await getInitialCFExpert() *
                    jsonDecode(data.entries.first.value)["value"].toDouble())));

    int next = 2;
    for (int index = 0; index < cfCombination.length; index++) {
      if (next > cfCombination.length - 1) {
        break;
      }
      double currentCF = cfTotal;
      double nextCF = cfCombination[next];
      cfTotal = currentCF + nextCF * (1 - currentCF);
      cfCombination[next] = cfTotal;
      next++;
      /**  
      print('Iterasi ke-$index');
      print('Nilai awal: $currentCF');
      print('Nilai berikutnya: $nextCF');
      print('CF Total setelah penggabungan: $cfTotal');

      print(
          'proses perhitungan: ${cfTotal += cfCombination[index] + (cfCombination[next] * (1 - cfCombination[index]))}');
      cfTotal += cfCombination[index] +
           (cfCombination[next] * (1 - cfCombination[index])); 
      **/
      
    }

    return cfTotal;
  }

  Stream<List<Diagnose>> searchDiagnose(String testTitle) {
    if (testTitle.isEmpty) {
      return diagnoseRepo.snapshots().map((snapshot) =>
          snapshot.docs.map((doc) => Diagnose.fromSnapshot(doc)).toList());
    } else {
      return diagnoseRepo.snapshots().map((snapshot) => snapshot.docs
          .where((doc) {
            String sqlLikePattern = ".*${RegExp.escape(testTitle)}.*";
            RegExp pattern = RegExp(sqlLikePattern, caseSensitive: false);
            return pattern.hasMatch(doc["test_title"]);
          })
          .map((doc) => Diagnose.fromSnapshot(doc))
          .toList());
    }
  }

  Future<void> deleteQA(String doc) async {
    await diagnoseRepo.doc(doc).delete().whenComplete(() {
      Get.snackbar("Completed", "Success Delete Diagnose");
    }).catchError((error, stackTrace) {
      Get.snackbar("Error", "Error While Delete Diagnose");
    });
  }

  Future<void> updateQA(Map<String, dynamic> data) async {
    await diagnoseRepo.doc(data['test_id']).update(data).whenComplete(() {
      Get.snackbar("Completed", "Success Update Diagnose");
    }).catchError((error, stackTrace) {
      Get.snackbar("Error", "Error While Update Diagnose");
    });
  }

  Future<void> insertQA(Map<String, dynamic> data) async {
    final newId = FirebaseFirestore.instance.collection('Diagnose').doc();
    data["test_id"] = newId.id;
    await newId.set(data).whenComplete(() {
      Get.snackbar("Completed", "Success Insert Diagnose");
    }).catchError((error, stackTrace) {
      Get.snackbar("Error", "Error While Insert Diagnose");
    });
  }

  Stream<List<Diagnose>> getAllDiagnose() => diagnoseRepo.snapshots().map((e) {
        return e.docs.map((e) => Diagnose.fromSnapshot(e)).toList();
      });
}
