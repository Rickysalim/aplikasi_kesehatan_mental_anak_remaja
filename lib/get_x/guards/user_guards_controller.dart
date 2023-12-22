import 'package:aplikasi_kesehatan_mental_anak_remaja/view/screens/landing_screen.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/view/screens/main_screen.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/view/screens/sign_in_screen.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserGuardsController extends GetxController {
  final user = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;

  @override
  void onReady() {
    firebaseUser = Rx<User?>(user.currentUser);
    firebaseUser.bindStream(user.userChanges());
    _setMainScreen();
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    if (user == null) {
      Get.offAll(SignInScreen());
    } else {
      Get.offAll(LandingScreen());
    }
  }

  _setMainScreen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int isviewed = prefs.getInt('MainScreen') ?? 0;
    if (isviewed != 1) {
      Get.off(MainScreen());
    }
  }
}
