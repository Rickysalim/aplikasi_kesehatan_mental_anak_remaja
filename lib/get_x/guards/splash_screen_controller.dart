import 'package:aplikasi_kesehatan_mental_anak_remaja/view/screens/main_screen.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/view/screens/sign_in_screen.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreenController extends GetxController {
  var isviewed = 0.obs;

  Future<void> setIsViewed(int isView) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('MainScreen', isView);
    Get.offAll(SignInScreen());
  }
}
