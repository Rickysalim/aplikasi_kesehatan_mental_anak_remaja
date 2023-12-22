import 'package:aplikasi_kesehatan_mental_anak_remaja/get_x/repository/crisis_support_controller_repository.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/models/CrisisSupport.dart';
import 'package:get/get.dart';

class CrisisSupportController extends GetxController {
    static CrisisSupportController get instance => Get.find();

    final crisisSupportRepositoryController = Get.put(CrisisSupportRepositoryController());

    Stream<List<CrisisSupport>> getAllCrisisSupport() => crisisSupportRepositoryController.getAllCrisisSupport();
    
}