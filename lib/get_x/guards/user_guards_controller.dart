import 'package:aplikasi_kesehatan_mental_anak_remaja/view/admin_screen/landing_screen_admin.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/view/auth_screen/email_verification_screen.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/view/user_screen/landing_screen.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/view/user_screen/main_screen.dart';
import 'package:aplikasi_kesehatan_mental_anak_remaja/view/auth_screen/sign_in_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserGuardsController extends GetxController {
  final user = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;

  final adminRepositoryController = FirebaseFirestore.instance.collection('Admin');

  Future<bool> isAdminOrUser(String uid) async {
    final checkRole = await adminRepositoryController.where("user_uid", isEqualTo: uid).get(); 
    if(checkRole.docs.isNotEmpty) {
      return true;
    }   
    return false;
  }


  @override
  void onReady() {
    firebaseUser = Rx<User?>(user.currentUser);
    firebaseUser.bindStream(user.userChanges());
    _setMainScreen();
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) async {
    if (user == null) {
      Get.offAll(SignInScreen());
    } else if (user.emailVerified) {
      final isAdmin = await isAdminOrUser(user.uid);
      if(isAdmin) {
        Get.offAll(AdminLandingScreen());
      } else {
        Get.offAll(LandingScreen());
      }
    } else {
      Get.to(EmailVerificationScreen());
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
