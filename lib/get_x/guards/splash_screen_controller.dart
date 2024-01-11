import 'package:aplikasi_kesehatan_mental_anak_remaja/view/user_screen/main_screen.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/view/auth_screen/sign_in_screen.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreenController extends GetxController {

  RxBool isLoading = RxBool(true);

  Future<void> setIsViewed(int isView) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('MainScreen', isView);
    Get.offAll(SignInScreen());
  }

  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 2), () {
       isLoading.value = false;
    });
  }
}
